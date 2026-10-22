package com.metaarch.catalog.coupon;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

public record CouponResponse(
    UUID id, String code, String name, String couponName, String description,
    String discountType, BigDecimal discount, BigDecimal minimumOrder,
    BigDecimal maximumDiscount, LocalDate startDate, LocalDate expiry,
    int usageLimit, Integer perUserLimit, String scope, String location,
    String store, String product, String category, String eligibility,
    String status, boolean active, Instant createdAt, Instant updatedAt) {
  static CouponResponse from(Coupon c) {
    return new CouponResponse(c.getId(), c.getCode(), c.getCode(), c.getCouponName(), c.getDescription(),
        "FIXED".equals(c.getDiscountType()) ? "Fixed" : "Percentage", c.getDiscount(), c.getMinimumOrder(),
        c.getMaximumDiscount(), c.getStartDate(), c.getExpiry(), c.getUsageLimit(), c.getPerUserLimit(),
        c.getScope(), c.getLocation(), c.getStore(), c.getProduct(), c.getCategory(), c.getEligibility(),
        c.getStatus(), "ACTIVE".equals(c.getStatus()), c.getCreatedAt(), c.getUpdatedAt());
  }
}
