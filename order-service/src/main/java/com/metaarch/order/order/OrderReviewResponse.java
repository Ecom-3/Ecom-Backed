package com.metaarch.order.order;

import java.time.Instant;
import java.util.*;

public record OrderReviewResponse(UUID id, UUID orderId, UUID productId, String productName,
  String orderNumber, int rating, String comment, List<String> photoUrls, ReviewStatus status, String adminReply,
  Instant createdAt, Instant updatedAt) { }
