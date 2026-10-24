package com.metaarch.order.order;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record GlobalStoreAssignmentRequest(@NotBlank @Size(max = 100) String storeId) { }
