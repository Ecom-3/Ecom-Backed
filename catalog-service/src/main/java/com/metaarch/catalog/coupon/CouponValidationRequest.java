package com.metaarch.catalog.coupon;

import java.math.BigDecimal;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record CouponValidationRequest(
    @NotBlank @Size(max = 64) String code,
    @NotNull @DecimalMin("0.00") BigDecimal subtotal,
    @Size(max = 150) String location,
    @Size(max = 150) String store) { }
