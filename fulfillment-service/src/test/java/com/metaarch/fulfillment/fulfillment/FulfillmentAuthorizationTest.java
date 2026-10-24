package com.metaarch.fulfillment.fulfillment;

import java.time.*;
import java.util.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.metaarch.fulfillment.shipment.*;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.security.oauth2.jwt.*;
import org.springframework.test.web.servlet.MockMvc;
import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest(properties={"spring.cloud.config.enabled=false",
  "spring.datasource.driver-class-name=org.h2.Driver",
  "spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.H2Dialect",
  "spring.sql.init.mode=always", "spring.sql.init.schema-locations=classpath:sync-schema.sql",
  "sync.dispatch-enabled=false", "sync.service=fulfillment-service",
  "sync.routes.fulfillment=notification-service", "sync.targets.notification-service=http://127.0.0.1:1"})
@AutoConfigureMockMvc
class FulfillmentAuthorizationTest {
  @Autowired MockMvc mvc;
  @Autowired FulfillmentRepository fulfillments;
  @Autowired ShipmentRepository shipments;
  @Autowired com.metaarch.fulfillment.event.FulfillmentOrderSnapshotRepository snapshots;
  @Autowired ObjectMapper mapper;
  @MockBean JwtDecoder decoder;
  UUID owner;
  Fulfillment fulfillment;
  Shipment shipment;

  @BeforeEach void setup() {
    owner = UUID.randomUUID();
    fulfillment = fulfillments.save(new Fulfillment(UUID.randomUUID(), owner, "store", FulfillmentType.SHIP_TO_HOME, UUID.randomUUID()));
    shipment = shipments.save(new Shipment(fulfillment, "carrier", UUID.randomUUID().toString(), LocalDate.now().plusDays(1)));
    reset(decoder);
    when(decoder.decode("owner")).thenReturn(token("owner", owner, "customer", "ROLE_CUSTOMER"));
    when(decoder.decode("stranger")).thenReturn(token("stranger", UUID.randomUUID(), "customer", "ROLE_CUSTOMER"));
    when(decoder.decode("admin")).thenReturn(token("admin", UUID.randomUUID(), "staff", "ROLE_ADMIN"));
    when(decoder.decode("global-admin")).thenReturn(token("global-admin", UUID.randomUUID(), "staff", "ROLE_GLOBAL_ADMIN"));
    when(decoder.decode("invalid")).thenThrow(new BadJwtException("Invalid signature"));
    when(decoder.decode("expired")).thenThrow(new BadJwtException("Expired token"));
  }
  private Jwt token(String value, UUID customer, String type, String role) {
    return Jwt.withTokenValue(value).header("alg", "HS512").subject(customer.toString())
      .claim("customerId", customer.toString()).claim("accountType", type).claim("roles", List.of(role))
      .issuedAt(Instant.now()).expiresAt(Instant.now().plusSeconds(300)).build();
  }
  @Test void allReadPathsRequireOwnerOrAdmin() throws Exception {
    for (String path : List.of("/api/v1/fulfillments/" + fulfillment.getId(),
      "/api/v1/fulfillments/order/" + fulfillment.getOrderId(),
      "/api/v1/shipments/order/" + fulfillment.getOrderId(),
      "/api/v1/shipments/" + shipment.getId() + "/tracking-events")) {
      mvc.perform(get(path)).andExpect(status().isUnauthorized());
      mvc.perform(get(path).header("Authorization", "Bearer invalid")).andExpect(status().isUnauthorized());
      mvc.perform(get(path).header("Authorization", "Bearer expired")).andExpect(status().isUnauthorized());
      mvc.perform(get(path).header("Authorization", "Bearer stranger")).andExpect(status().isForbidden());
      mvc.perform(get(path).header("Authorization", "Bearer owner")).andExpect(status().isOk());
      mvc.perform(get(path).header("Authorization", "Bearer admin")).andExpect(status().isOk());
    }
  }
  @Test void ownersCannotChangeStatusButAdminCan() throws Exception {
    String path = "/api/v1/fulfillments/" + fulfillment.getId() + "/status";
    mvc.perform(patch(path).header("Authorization", "Bearer owner").contentType(MediaType.APPLICATION_JSON)
      .content("{\"status\":\"ALLOCATED\"}")).andExpect(status().isForbidden());
    mvc.perform(patch(path).header("Authorization", "Bearer admin").contentType(MediaType.APPLICATION_JSON)
      .content("{\"status\":\"ALLOCATED\"}")).andExpect(status().isOk());
    mvc.perform(patch("/api/v1/shipments/" + shipment.getId() + "/delivered")
      .header("Authorization", "Bearer owner")).andExpect(status().isForbidden());
  }

  @Test void customersCannotForgeShipmentOrTimeline() throws Exception {
    for (String token : List.of("owner", "stranger")) {
      mvc.perform(patch("/api/v1/shipments/" + shipment.getId() + "/status")
        .header("Authorization", "Bearer " + token).contentType(MediaType.APPLICATION_JSON)
        .content("{\"status\":\"IN_TRANSIT\"}")).andExpect(status().isForbidden());
      mvc.perform(post("/api/v1/shipments/" + shipment.getId() + "/tracking-events")
        .header("Authorization", "Bearer " + token).contentType(MediaType.APPLICATION_JSON)
        .content("{\"status\":\"IN_TRANSIT\",\"location\":\"Forged location\",\"description\":\"Forged update\",\"eventTime\":\"2026-10-11T10:00:00Z\"}"))
        .andExpect(status().isForbidden());
    }
  }

  @Test void globalAdminCanCreateGlobalFulfillment() throws Exception {
    UUID orderId = UUID.randomUUID();
    UUID customerId = UUID.randomUUID();
    UUID addressId = UUID.randomUUID();
    snapshots.saveAndFlush(new com.metaarch.fulfillment.event.FulfillmentOrderSnapshot(
        orderId, customerId, "global-store", addressId, FulfillmentType.GLOBAL));
    String body = "{\"orderId\":\"%s\",\"customerId\":\"%s\",\"storeId\":\"global-store\",\"shippingAddressId\":\"%s\",\"fulfillmentType\":\"GLOBAL\"}"
        .formatted(orderId, customerId, addressId);

    mvc.perform(post("/api/v1/fulfillments").header("Authorization", "Bearer global-admin")
        .contentType(MediaType.APPLICATION_JSON).content(body))
        .andExpect(status().isCreated())
        .andExpect(jsonPath("$.orderId").value(orderId.toString()))
        .andExpect(jsonPath("$.fulfillmentType").value("GLOBAL"));
  }

  @Test void isolatedGlobalOrderPersistsFulfillmentAndShipmentThroughApi() throws Exception {
    UUID orderId = UUID.randomUUID();
    UUID customerId = UUID.randomUUID();
    UUID addressId = UUID.randomUUID();
    snapshots.saveAndFlush(new com.metaarch.fulfillment.event.FulfillmentOrderSnapshot(
        orderId, customerId, "global-store", addressId, FulfillmentType.GLOBAL));
    String fulfillmentBody = "{\"orderId\":\"%s\",\"customerId\":\"%s\",\"storeId\":\"global-store\",\"shippingAddressId\":\"%s\",\"fulfillmentType\":\"GLOBAL\"}"
        .formatted(orderId, customerId, addressId);

    var createdFulfillment = mvc.perform(post("/api/v1/fulfillments").header("Authorization", "Bearer global-admin")
        .contentType(MediaType.APPLICATION_JSON).content(fulfillmentBody))
        .andExpect(status().isCreated()).andReturn();
    UUID fulfillmentId = UUID.fromString(mapper.readTree(createdFulfillment.getResponse().getContentAsString()).get("id").asText());
    assertThat(fulfillments.findByOrderId(orderId)).isPresent();

    for (String next : List.of("ALLOCATED", "PACKING", "READY_TO_SHIP")) {
      mvc.perform(patch("/api/v1/fulfillments/" + fulfillmentId + "/status")
          .header("Authorization", "Bearer global-admin").contentType(MediaType.APPLICATION_JSON)
          .content("{\"status\":\"" + next + "\"}"))
          .andExpect(status().isOk());
    }

    String shipmentBody = "{\"fulfillmentId\":\"%s\",\"carrier\":\"QA Local\",\"trackingNumber\":\"QA-%s\",\"estimatedDeliveryDate\":\"%s\"}"
        .formatted(fulfillmentId, UUID.randomUUID(), LocalDate.now().plusDays(2));
    var createdShipment = mvc.perform(post("/api/v1/shipments").header("Authorization", "Bearer global-admin")
        .contentType(MediaType.APPLICATION_JSON).content(shipmentBody))
        .andExpect(status().isCreated()).andExpect(jsonPath("$.orderId").value(orderId.toString())).andReturn();
    UUID shipmentId = UUID.fromString(mapper.readTree(createdShipment.getResponse().getContentAsString()).get("id").asText());

    mvc.perform(get("/api/v1/fulfillments/order/" + orderId).header("Authorization", "Bearer global-admin"))
        .andExpect(status().isOk()).andExpect(jsonPath("$.status").value("READY_TO_SHIP"));
    mvc.perform(get("/api/v1/shipments/order/" + orderId).header("Authorization", "Bearer global-admin"))
        .andExpect(status().isOk()).andExpect(jsonPath("$.status").value("CREATED"));
    assertThat(shipments.findByOrderId(orderId)).isPresent();

    mvc.perform(patch("/api/v1/shipments/" + shipmentId + "/status")
        .header("Authorization", "Bearer global-admin").contentType(MediaType.APPLICATION_JSON)
        .content("{\"status\":\"IN_TRANSIT\"}"))
        .andExpect(status().isOk()).andExpect(jsonPath("$.status").value("IN_TRANSIT"));
    mvc.perform(get("/api/v1/fulfillments/order/" + orderId).header("Authorization", "Bearer global-admin"))
        .andExpect(status().isOk()).andExpect(jsonPath("$.status").value("SHIPPED"));

    mvc.perform(patch("/api/v1/shipments/" + shipmentId + "/status")
        .header("Authorization", "Bearer global-admin").contentType(MediaType.APPLICATION_JSON)
        .content("{\"status\":\"OUT_FOR_DELIVERY\"}"))
        .andExpect(status().isOk()).andExpect(jsonPath("$.status").value("OUT_FOR_DELIVERY"));
    mvc.perform(patch("/api/v1/shipments/" + shipmentId + "/status")
        .header("Authorization", "Bearer global-admin").contentType(MediaType.APPLICATION_JSON)
        .content("{\"status\":\"DELIVERED\"}"))
        .andExpect(status().isOk()).andExpect(jsonPath("$.status").value("DELIVERED"));
    mvc.perform(get("/api/v1/fulfillments/order/" + orderId).header("Authorization", "Bearer global-admin"))
        .andExpect(status().isOk()).andExpect(jsonPath("$.status").value("DELIVERED"));
    assertThat(shipments.findByOrderId(orderId)).isPresent();
  }
  @Test void managersAreBoundToPersistedStoreAndSnapshot() throws Exception {
    for (String store : List.of("store", "foreign")) {
      when(decoder.decode(store)).thenReturn(Jwt.withTokenValue(store).header("alg", "HS512").subject("manager")
          .claim("accountType", "staff").claim("authorities", List.of("ROLE_STORE_MANAGER", "SCOPE_STORE:" + store)).build());
    }
    var path = "/api/v1/fulfillments/" + fulfillment.getId();
    mvc.perform(get(path).header("Authorization", "Bearer foreign")).andExpect(status().isForbidden());
    mvc.perform(get(path).header("Authorization", "Bearer store")).andExpect(status().isOk());
    mvc.perform(patch(path + "/status").header("Authorization", "Bearer foreign").contentType(MediaType.APPLICATION_JSON)
        .content("{\"status\":\"ALLOCATED\"}")).andExpect(status().isForbidden());
    mvc.perform(patch(path + "/status").header("Authorization", "Bearer store").contentType(MediaType.APPLICATION_JSON)
        .content("{\"status\":\"ALLOCATED\"}")).andExpect(status().isOk());
    var id = UUID.randomUUID(); var address = UUID.randomUUID();
    snapshots.save(new com.metaarch.fulfillment.event.FulfillmentOrderSnapshot(id, owner, "store", address, FulfillmentType.SHIP_TO_HOME));
    String body = "{\"orderId\":\"%s\",\"customerId\":\"%s\",\"storeId\":\"store\",\"shippingAddressId\":\"%s\",\"fulfillmentType\":\"SHIP_TO_HOME\"}".formatted(id, owner, address);
    mvc.perform(post("/api/v1/fulfillments").header("Authorization", "Bearer store").contentType(MediaType.APPLICATION_JSON)
        .content(body.replace(owner.toString(), UUID.randomUUID().toString()))).andExpect(status().isForbidden());
    mvc.perform(post("/api/v1/fulfillments").header("Authorization", "Bearer store").contentType(MediaType.APPLICATION_JSON)
        .content(body)).andExpect(status().isCreated());
  }
}
