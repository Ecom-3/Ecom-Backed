package com.metaarch.order.order;

import java.util.List;

public record GlobalStoreAssignmentOption(String storeId, List<ItemAvailability> items) {
  public record ItemAvailability(String productName, int requestedQuantity, int availableQuantity, boolean available) { }
}
