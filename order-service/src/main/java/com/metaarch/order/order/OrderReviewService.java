package com.metaarch.order.order;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.metaarch.order.exception.InvalidOrderStateException;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderReviewService {
  private final OrderRepository orders;
  private final JdbcTemplate jdbc;
  private final ObjectMapper mapper;
  private final ReviewDeliveryVerifier deliveryVerifier;

  @Autowired
  public OrderReviewService(OrderRepository orders, JdbcTemplate jdbc, ObjectMapper mapper, ReviewDeliveryVerifier deliveryVerifier) {
    this.orders=orders; this.jdbc=jdbc; this.mapper=mapper; this.deliveryVerifier=deliveryVerifier;
  }

  OrderReviewService(OrderRepository orders, JdbcTemplate jdbc, ObjectMapper mapper) {
    this(orders, jdbc, mapper, null);
  }

  @Transactional
  public OrderReviewResponse save(UUID orderId, OrderReviewRequest request) {
    Order order=orders.findLockedById(orderId).orElseThrow(() -> new com.metaarch.order.exception.ResourceNotFoundException("Order not found"));
    // A stale order row is not proof of delivery. Require the authoritative
    // order lifecycle to confirm eligibility before writing a customer review.
    boolean delivered = order.getStatus() == OrderStatus.DELIVERED
      || deliveryVerifier != null && deliveryVerifier.isDelivered(orderId);
    if (!delivered || order.getStatus() == OrderStatus.CANCELLED)
      throw new InvalidOrderStateException("A review can be submitted after delivery is complete.");
    var item = request.productId() == null
      ? order.getItems().stream().findFirst().orElseThrow(() -> new InvalidOrderStateException("This order has no reviewable product."))
      : order.getItems().stream().filter(candidate -> request.productId().equals(candidate.getProductId())).findFirst()
          .orElseThrow(() -> new IllegalArgumentException("Choose a product from this order."));
    List<String> photos=Optional.ofNullable(request.photoUrls()).orElse(List.of()).stream().filter(Objects::nonNull).map(String::trim).filter(value -> value.startsWith("data:image/") || value.startsWith("https://")).toList();
    if (photos.size()!=Optional.ofNullable(request.photoUrls()).orElse(List.of()).size()) throw new IllegalArgumentException("Review photos must be image data or HTTPS URLs.");
    String photoJson;
    try { photoJson=mapper.writeValueAsString(photos); } catch (Exception error) { throw new IllegalArgumentException("Review photos could not be saved.",error); }
    jdbc.update("INSERT INTO order_reviews (id,order_id,customer_id,product_id,product_name,rating,comment,photo_urls,status,admin_reply,created_at,updated_at) VALUES (UUID_TO_BIN(?),UUID_TO_BIN(?),UUID_TO_BIN(?),UUID_TO_BIN(?),?,?,?,?,'PENDING',NULL,NOW(6),NOW(6)) ON DUPLICATE KEY UPDATE product_id=VALUES(product_id),product_name=VALUES(product_name),rating=VALUES(rating),comment=VALUES(comment),photo_urls=VALUES(photo_urls),status='PENDING',admin_reply=NULL,updated_at=NOW(6)",UUID.randomUUID().toString(),orderId.toString(),order.getCustomerId().toString(),item.getProductId().toString(),item.getProductName(),request.rating(),Optional.ofNullable(request.comment()).orElse("").trim(),photoJson);
    return get(orderId).orElseThrow();
  }

  @Transactional(readOnly=true)
  public Optional<OrderReviewResponse> get(UUID orderId) {
    return jdbc.query("SELECT BIN_TO_UUID(r.id) id,BIN_TO_UUID(r.order_id) order_id,BIN_TO_UUID(r.customer_id) customer_id,BIN_TO_UUID(r.product_id) product_id,r.product_name,o.order_number,r.rating,r.comment,r.photo_urls,r.status,r.admin_reply,r.created_at,r.updated_at FROM order_reviews r JOIN orders o ON o.id=r.order_id WHERE r.order_id=UUID_TO_BIN(?)", this::mapReview, orderId.toString()).stream().findFirst();
  }

  @Transactional(readOnly=true)
  public Optional<OrderReviewResponse> get(UUID orderId, UUID productId) {
    return jdbc.query("SELECT BIN_TO_UUID(r.id) id,BIN_TO_UUID(r.order_id) order_id,BIN_TO_UUID(r.customer_id) customer_id,BIN_TO_UUID(r.product_id) product_id,r.product_name,o.order_number,r.rating,r.comment,r.photo_urls,r.status,r.admin_reply,r.created_at,r.updated_at FROM order_reviews r JOIN orders o ON o.id=r.order_id WHERE r.order_id=UUID_TO_BIN(?) AND r.product_id=UUID_TO_BIN(?)", this::mapReview, orderId.toString(),productId.toString()).stream().findFirst();
  }

  @Transactional(readOnly=true)
  public List<OrderReviewResponse> getForOrder(UUID orderId) {
    return jdbc.query("SELECT BIN_TO_UUID(r.id) id,BIN_TO_UUID(r.order_id) order_id,BIN_TO_UUID(r.customer_id) customer_id,BIN_TO_UUID(r.product_id) product_id,r.product_name,o.order_number,r.rating,r.comment,r.photo_urls,r.status,r.admin_reply,r.created_at,r.updated_at FROM order_reviews r JOIN orders o ON o.id=r.order_id WHERE r.order_id=UUID_TO_BIN(?) ORDER BY r.created_at DESC",this::mapReview,orderId.toString());
  }

  @Transactional(readOnly=true)
  public ReviewPageResponse<OrderReviewResponse> adminList(ReviewStatus status, int page, int size, boolean globalOnly) {
    String filter = " WHERE 1=1";
    List<Object> args = new ArrayList<>();
    if (status != null) { filter += " AND r.status=?"; args.add(status.name()); }
    if (globalOnly) filter += " AND (o.fulfillment_type='global' OR o.store_id='global-store')";
    Long total = jdbc.queryForObject("SELECT COUNT(*) FROM order_reviews r JOIN orders o ON o.id=r.order_id" + filter, Long.class, args.toArray());
    args.add(size); args.add(page * size);
    List<OrderReviewResponse> content = jdbc.query("SELECT BIN_TO_UUID(r.id) id,BIN_TO_UUID(r.order_id) order_id,BIN_TO_UUID(r.customer_id) customer_id,BIN_TO_UUID(r.product_id) product_id,r.product_name,o.order_number,r.rating,r.comment,r.photo_urls,r.status,r.admin_reply,r.created_at,r.updated_at FROM order_reviews r JOIN orders o ON o.id=r.order_id" + filter + " ORDER BY r.created_at DESC LIMIT ? OFFSET ?", this::mapReview, args.toArray());
    long count = total == null ? 0 : total;
    return new ReviewPageResponse<>(content, count, (int)Math.ceil((double)count / size), size, page);
  }

  @Transactional
  public OrderReviewResponse moderate(UUID reviewId, AdminReviewUpdateRequest request, boolean globalOnly) {
    String scope = globalOnly ? " AND (o.fulfillment_type='global' OR o.store_id='global-store')" : "";
    int updated = jdbc.update("UPDATE order_reviews r JOIN orders o ON o.id=r.order_id SET r.status=?,r.admin_reply=?,r.updated_at=NOW(6) WHERE r.id=UUID_TO_BIN(?)" + scope,
      request.status().name(), Optional.ofNullable(request.adminReply()).map(String::trim).filter(value -> !value.isEmpty()).orElse(null), reviewId.toString());
    if (updated == 0) throw new com.metaarch.order.exception.ResourceNotFoundException("Review not found");
    return jdbc.query("SELECT BIN_TO_UUID(r.id) id,BIN_TO_UUID(r.order_id) order_id,BIN_TO_UUID(r.customer_id) customer_id,BIN_TO_UUID(r.product_id) product_id,r.product_name,o.order_number,r.rating,r.comment,r.photo_urls,r.status,r.admin_reply,r.created_at,r.updated_at FROM order_reviews r JOIN orders o ON o.id=r.order_id WHERE r.id=UUID_TO_BIN(?)",this::mapReview,reviewId.toString()).stream().findFirst().orElseThrow();
  }

  @Transactional(readOnly=true)
  public List<ProductReviewResponse> publicProductReviews(UUID productId) {
    return jdbc.query("SELECT BIN_TO_UUID(r.id) id,BIN_TO_UUID(r.product_id) product_id,r.product_name,r.rating,r.comment,r.photo_urls,r.admin_reply,r.created_at FROM order_reviews r WHERE r.product_id=UUID_TO_BIN(?) AND r.status='APPROVED' ORDER BY r.created_at DESC",this::mapPublicReview,productId.toString());
  }

  @Transactional(readOnly=true)
  public List<ProductReviewResponse> publicProductReviews(List<UUID> productIds) {
    if (productIds.isEmpty()) return List.of();
    String placeholders=String.join(",",Collections.nCopies(productIds.size(),"UUID_TO_BIN(?)"));
    return jdbc.query("SELECT BIN_TO_UUID(r.id) id,BIN_TO_UUID(r.product_id) product_id,r.product_name,r.rating,r.comment,r.photo_urls,r.admin_reply,r.created_at FROM order_reviews r WHERE r.product_id IN ("+placeholders+") AND r.status='APPROVED' ORDER BY r.created_at DESC",this::mapPublicReview,productIds.stream().map(UUID::toString).toArray());
  }

  @Transactional(readOnly=true)
  public List<OrderReviewResponse> customerReviews(UUID customerId) {
    return jdbc.query("SELECT BIN_TO_UUID(r.id) id,BIN_TO_UUID(r.order_id) order_id,BIN_TO_UUID(r.customer_id) customer_id,BIN_TO_UUID(r.product_id) product_id,r.product_name,o.order_number,r.rating,r.comment,r.photo_urls,r.status,r.admin_reply,r.created_at,r.updated_at FROM order_reviews r JOIN orders o ON o.id=r.order_id WHERE r.customer_id=UUID_TO_BIN(?) ORDER BY r.created_at DESC",this::mapReview,customerId.toString());
  }

  private OrderReviewResponse mapReview(java.sql.ResultSet rs, int row) throws java.sql.SQLException {
    List<String> photos;
    try { photos=mapper.readValue(rs.getString("photo_urls"),new TypeReference<List<String>>(){}); } catch(Exception error) { photos=List.of(); }
    String productId = rs.getString("product_id");
    return new OrderReviewResponse(UUID.fromString(rs.getString("id")),UUID.fromString(rs.getString("order_id")),productId == null ? null : UUID.fromString(productId),rs.getString("product_name"),rs.getString("order_number"),rs.getInt("rating"),rs.getString("comment"),photos,ReviewStatus.valueOf(rs.getString("status")),rs.getString("admin_reply"),rs.getTimestamp("created_at").toInstant(),rs.getTimestamp("updated_at").toInstant());
  }

  private ProductReviewResponse mapPublicReview(java.sql.ResultSet rs, int row) throws java.sql.SQLException {
    List<String> photos;
    try { photos=mapper.readValue(rs.getString("photo_urls"),new TypeReference<List<String>>(){}); } catch(Exception error) { photos=List.of(); }
    return new ProductReviewResponse(UUID.fromString(rs.getString("id")),UUID.fromString(rs.getString("product_id")),rs.getString("product_name"),rs.getInt("rating"),rs.getString("comment"),photos,ReviewStatus.APPROVED,rs.getString("admin_reply"),rs.getTimestamp("created_at").toInstant());
  }
}
