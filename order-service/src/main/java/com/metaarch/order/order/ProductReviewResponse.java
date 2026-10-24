package com.metaarch.order.order;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record ProductReviewResponse(UUID id, UUID productId, String productName, int rating,
  String comment, List<String> photoUrls, ReviewStatus status, String adminReply, Instant createdAt) { }
