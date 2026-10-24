package com.metaarch.order.order;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

@DataJpaTest(properties = {"spring.jpa.hibernate.ddl-auto=create-drop", "spring.flyway.enabled=false", "spring.cloud.config.enabled=false"})
class GlobalStoreAssignmentPersistenceTest {
  @Autowired OrderRepository orders;

  @Test void assignmentFieldsSurviveDatabaseRefresh() {
    Order order = new Order(UUID.randomUUID(), UUID.randomUUID(), "global-store", "GLOBAL-PERSIST-1");
    order.setFulfillmentType("global");
    order.setGlobalApproval("Approved");
    order.setGlobalAssignedStoreId("store-hyd");
    order.setGlobalAssignedAt(java.time.Instant.parse("2026-10-23T09:00:00Z"));
    order.setStatus(OrderStatus.CONFIRMED);
    order = orders.saveAndFlush(order);

    Order refreshed = orders.findById(order.getId()).orElseThrow();
    assertThat(refreshed.getGlobalAssignedStoreId()).isEqualTo("store-hyd");
    assertThat(refreshed.getGlobalAssignedAt()).isEqualTo(order.getGlobalAssignedAt());
    assertThat(refreshed.getGlobalApproval()).isEqualTo("Approved");
  }
}
