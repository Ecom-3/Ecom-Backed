package com.metaarch.catalog.coupon;

import java.math.BigDecimal;

public record CouponValidationResponse(
    boolean valid, String message, String code, String couponName,
    String discountType, BigDecimal discount, BigDecimal maximumDiscount,
    BigDecimal minimumOrder, BigDecimal discountAmount) { }
