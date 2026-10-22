package com.metaarch.catalog.coupon;

import java.math.BigDecimal;
import java.time.LocalDate;
import jakarta.validation.constraints.*;

public record CouponRequest(
    @NotBlank @Size(max = 64) String code,
    @NotBlank @Size(max = 180) String couponName,
    String description,
    @NotBlank @Pattern(regexp = "(?i)percentage|fixed") String discountType,
    @NotNull @DecimalMin("0.01") BigDecimal discount,
    @NotNull @DecimalMin("0.00") BigDecimal minimumOrder,
    @DecimalMin("0.00") BigDecimal maximumDiscount,
    @NotNull LocalDate startDate,
    @NotNull LocalDate expiry,
    @Positive int usageLimit,
    @Positive Integer perUserLimit,
    @Pattern(regexp = "(?i)global|location|store") String scope,
    @Size(max = 150) String location,
    @Size(max = 150) String store,
    @Size(max = 180) String product,
    @Size(max = 180) String category,
    @Size(max = 60) String eligibility,
    @Pattern(regexp = "(?i)active|inactive") String status) {}
