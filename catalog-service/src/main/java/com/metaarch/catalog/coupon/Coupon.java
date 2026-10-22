package com.metaarch.catalog.coupon;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;
import com.metaarch.catalog.common.AuditedEntity;
import jakarta.persistence.*;

@Entity
@Table(name = "coupons", uniqueConstraints = @UniqueConstraint(name = "uk_coupons_code", columnNames = "code"))
public class Coupon extends AuditedEntity {
  @Id @GeneratedValue(strategy = GenerationType.UUID) private UUID id;
  @Column(nullable = false, length = 64) private String code;
  @Column(name = "coupon_name", nullable = false, length = 180) private String couponName;
  @Column(columnDefinition = "TEXT") private String description;
  @Column(name = "discount_type", nullable = false, length = 20) private String discountType;
  @Column(nullable = false, precision = 12, scale = 2) private BigDecimal discount;
  @Column(name = "minimum_order", nullable = false, precision = 12, scale = 2) private BigDecimal minimumOrder;
  @Column(name = "maximum_discount", precision = 12, scale = 2) private BigDecimal maximumDiscount;
  @Column(name = "start_date", nullable = false) private LocalDate startDate;
  @Column(nullable = false) private LocalDate expiry;
  @Column(name = "usage_limit", nullable = false) private int usageLimit;
  @Column(name = "per_user_limit") private Integer perUserLimit;
  @Column(nullable = false, length = 20) private String scope;
  @Column(length = 150) private String location;
  @Column(length = 150) private String store;
  @Column(length = 180) private String product;
  @Column(length = 180) private String category;
  @Column(nullable = false, length = 60) private String eligibility;
  @Column(nullable = false, length = 20) private String status;

  protected Coupon() {}

  public UUID getId() { return id; }
  public String getCode() { return code; } public void setCode(String v) { code = v; }
  public String getCouponName() { return couponName; } public void setCouponName(String v) { couponName = v; }
  public String getDescription() { return description; } public void setDescription(String v) { description = v; }
  public String getDiscountType() { return discountType; } public void setDiscountType(String v) { discountType = v; }
  public BigDecimal getDiscount() { return discount; } public void setDiscount(BigDecimal v) { discount = v; }
  public BigDecimal getMinimumOrder() { return minimumOrder; } public void setMinimumOrder(BigDecimal v) { minimumOrder = v; }
  public BigDecimal getMaximumDiscount() { return maximumDiscount; } public void setMaximumDiscount(BigDecimal v) { maximumDiscount = v; }
  public LocalDate getStartDate() { return startDate; } public void setStartDate(LocalDate v) { startDate = v; }
  public LocalDate getExpiry() { return expiry; } public void setExpiry(LocalDate v) { expiry = v; }
  public int getUsageLimit() { return usageLimit; } public void setUsageLimit(int v) { usageLimit = v; }
  public Integer getPerUserLimit() { return perUserLimit; } public void setPerUserLimit(Integer v) { perUserLimit = v; }
  public String getScope() { return scope; } public void setScope(String v) { scope = v; }
  public String getLocation() { return location; } public void setLocation(String v) { location = v; }
  public String getStore() { return store; } public void setStore(String v) { store = v; }
  public String getProduct() { return product; } public void setProduct(String v) { product = v; }
  public String getCategory() { return category; } public void setCategory(String v) { category = v; }
  public String getEligibility() { return eligibility; } public void setEligibility(String v) { eligibility = v; }
  public String getStatus() { return status; } public void setStatus(String v) { status = v; }
}
