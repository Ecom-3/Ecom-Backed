package com.metaarch.catalog.coupon;

import java.math.BigDecimal;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import java.time.LocalDate;
import com.metaarch.catalog.exception.ConflictException;
import com.metaarch.catalog.exception.ResourceNotFoundException;
import com.metaarch.catalog.store.StoreRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CouponService {
  private final CouponRepository coupons;
  private final StoreRepository stores;
  public CouponService(CouponRepository coupons,StoreRepository stores) { this.coupons = coupons; this.stores=stores; }

  @Transactional(readOnly = true)
  public List<CouponResponse> list() { return coupons.findAllByOrderByCreatedAtDesc().stream().map(CouponResponse::from).toList(); }

  @Transactional(readOnly = true)
  public CouponValidationResponse validate(CouponValidationRequest request) {
    String code=clean(request.code()).toUpperCase(Locale.ROOT);
    Coupon coupon=coupons.findFirstByCodeIgnoreCase(code).orElse(null);
    if(coupon==null || !"ACTIVE".equals(coupon.getStatus())) return invalid("Coupon not found or inactive.",code);
    LocalDate today=LocalDate.now();
    if(today.isBefore(coupon.getStartDate()) || today.isAfter(coupon.getExpiry())) return invalid("This coupon is not valid today.",code);
    if(request.subtotal().compareTo(coupon.getMinimumOrder())<0) return invalid("Minimum order is ₹"+coupon.getMinimumOrder().setScale(2)+".",code);
    String scope=valueOr(coupon.getScope(),"GLOBAL").toUpperCase(Locale.ROOT);
    if("LOCATION".equals(scope) && !sameText(coupon.getLocation(),request.location())) return invalid("This coupon is not valid for this delivery location.",code);
    if("STORE".equals(scope) && !storeMatches(coupon.getStore(),request.store())) return invalid("This coupon is not valid for this store.",code);
    if(coupon.getProduct()!=null || coupon.getCategory()!=null) return invalid("This coupon requires product eligibility that is not available for this cart.",code);
    if(!"ALL CUSTOMERS".equals(valueOr(coupon.getEligibility(),"All customers").toUpperCase(Locale.ROOT))) return invalid("This coupon has customer eligibility requirements that could not be verified.",code);
    BigDecimal raw="FIXED".equals(coupon.getDiscountType())?coupon.getDiscount():request.subtotal().multiply(coupon.getDiscount()).divide(new BigDecimal("100"),2,java.math.RoundingMode.HALF_UP);
    BigDecimal discount=raw.min(request.subtotal());
    if(coupon.getMaximumDiscount()!=null) discount=discount.min(coupon.getMaximumDiscount());
    return new CouponValidationResponse(true,code+" applied successfully.",code,coupon.getCouponName(),coupon.getDiscountType(),coupon.getDiscount(),coupon.getMaximumDiscount(),coupon.getMinimumOrder(),discount.setScale(2,java.math.RoundingMode.HALF_UP));
  }

  private CouponValidationResponse invalid(String message,String code) { return new CouponValidationResponse(false,message,code,null,null,null,null,null,BigDecimal.ZERO.setScale(2)); }
  private boolean sameText(String left,String right) { return left!=null && right!=null && left.trim().equalsIgnoreCase(right.trim()); }
  private boolean storeMatches(String couponStore,String storeRef) {
    if(sameText(couponStore,storeRef)) return true;
    return storeRef!=null && stores.findById(storeRef.trim()).map(store->sameText(couponStore,store.getName())).orElse(false);
  }

  @Transactional
  public CouponResponse create(CouponRequest request) {
    String code = clean(request.code()).toUpperCase(Locale.ROOT);
    if (coupons.existsByCodeIgnoreCase(code)) throw new ConflictException("A coupon with this code already exists");
    Coupon coupon = new Coupon();
    apply(coupon, request);
    return CouponResponse.from(coupons.save(coupon));
  }

  @Transactional
  public CouponResponse update(UUID id, CouponRequest request) {
    Coupon coupon = find(id);
    String code = clean(request.code()).toUpperCase(Locale.ROOT);
    if (coupons.existsByCodeIgnoreCaseAndIdNot(code, id)) throw new ConflictException("A coupon with this code already exists");
    apply(coupon, request);
    return CouponResponse.from(coupon);
  }

  @Transactional
  public CouponResponse setStatus(UUID id, String rawStatus) {
    Coupon coupon = find(id);
    String status = rawStatus == null ? "ACTIVE" : rawStatus.trim().toUpperCase(Locale.ROOT);
    if (!List.of("ACTIVE", "INACTIVE").contains(status)) throw new IllegalArgumentException("Coupon status must be ACTIVE or INACTIVE");
    coupon.setStatus(status);
    return CouponResponse.from(coupon);
  }

  @Transactional
  public void delete(UUID id) { coupons.delete(find(id)); }

  private Coupon find(UUID id) { return coupons.findById(id).orElseThrow(() -> new ResourceNotFoundException("Coupon not found: " + id)); }

  private void apply(Coupon coupon, CouponRequest request) {
    String discountType = clean(request.discountType()).toUpperCase(Locale.ROOT);
    BigDecimal discount = request.discount();
    if ("PERCENTAGE".equals(discountType) && discount.compareTo(new BigDecimal("100")) > 0)
      throw new IllegalArgumentException("Percentage discounts cannot exceed 100");
    if (request.expiry().isBefore(request.startDate())) throw new IllegalArgumentException("Expiry must be on or after the start date");
    coupon.setCode(clean(request.code()).toUpperCase(Locale.ROOT));
    coupon.setCouponName(clean(request.couponName()));
    coupon.setDescription(blankToNull(request.description()));
    coupon.setDiscountType(discountType);
    coupon.setDiscount(discount);
    coupon.setMinimumOrder(request.minimumOrder() == null ? BigDecimal.ZERO : request.minimumOrder());
    coupon.setMaximumDiscount(request.maximumDiscount());
    coupon.setStartDate(request.startDate());
    coupon.setExpiry(request.expiry());
    coupon.setUsageLimit(request.usageLimit());
    coupon.setPerUserLimit(request.perUserLimit());
    coupon.setScope(valueOr(request.scope(), "GLOBAL").toUpperCase(Locale.ROOT));
    coupon.setLocation(blankToNull(request.location()));
    coupon.setStore(blankToNull(request.store()));
    coupon.setProduct(blankToNull(request.product()));
    coupon.setCategory(blankToNull(request.category()));
    coupon.setEligibility(valueOr(request.eligibility(), "All customers"));
    String status = valueOr(request.status(), "ACTIVE").toUpperCase(Locale.ROOT);
    if (!List.of("ACTIVE", "INACTIVE").contains(status)) throw new IllegalArgumentException("Coupon status must be ACTIVE or INACTIVE");
    coupon.setStatus(status);
  }

  private String clean(String value) { return value == null ? "" : value.trim(); }
  private String blankToNull(String value) { String clean = clean(value); return clean.isEmpty() ? null : clean; }
  private String valueOr(String value, String fallback) { String clean = clean(value); return clean.isEmpty() ? fallback : clean; }
}
