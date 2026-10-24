package com.metaarch.order.order;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import java.util.UUID;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/reviews")
@Validated
public class OrderReviewAdminController {
  private final OrderReviewService reviews;
  private final OrderAccess access;

  public OrderReviewAdminController(OrderReviewService reviews, OrderAccess access) { this.reviews=reviews; this.access=access; }

  @PreAuthorize("@orderAccess.reviewModerator()")
  @GetMapping("/admin")
  public ReviewPageResponse<OrderReviewResponse> list(@RequestParam(required=false) ReviewStatus status,
      @RequestParam(defaultValue="0") @Min(0) int page, @RequestParam(defaultValue="20") @Min(1) @Max(100) int size) {
    return reviews.adminList(status,page,size,!access.superAdmin());
  }

  @PreAuthorize("@orderAccess.reviewModerator()")
  @PatchMapping("/admin/{reviewId}")
  public OrderReviewResponse moderate(@PathVariable UUID reviewId, @Valid @RequestBody AdminReviewUpdateRequest request) {
    return reviews.moderate(reviewId,request,!access.superAdmin());
  }

  @PreAuthorize("@orderAccess.customerReviewReader()")
  @GetMapping("/mine")
  public ResponseEntity<?> mine() {
    UUID customerId=access.currentCustomerId();
    return customerId == null ? ResponseEntity.status(403).build() : ResponseEntity.ok(reviews.customerReviews(customerId));
  }

  @GetMapping("/products/{productId}")
  public java.util.List<ProductReviewResponse> byProduct(@PathVariable UUID productId) { return reviews.publicProductReviews(productId); }

  @GetMapping("/products")
  public java.util.List<ProductReviewResponse> byProducts(@RequestParam java.util.List<UUID> productIds) {
    if (productIds.size() > 100) throw new IllegalArgumentException("At most 100 product IDs can be requested.");
    return reviews.publicProductReviews(productIds.stream().distinct().toList());
  }
}
