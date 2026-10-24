package com.metaarch.order.order;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record AdminReviewUpdateRequest(@NotNull ReviewStatus status, @Size(max = 1000) String adminReply) { }
