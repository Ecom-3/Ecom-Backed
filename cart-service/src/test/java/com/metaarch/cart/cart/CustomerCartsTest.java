package com.metaarch.cart.cart;

import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.jwt;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest(properties = "spring.jpa.open-in-view=false")
@AutoConfigureMockMvc
class CustomerCartsTest {
  @Autowired MockMvc mvc;
  @Autowired CartRepository carts;

  private Cart cart(UUID customerId, String storeId, CartStatus status) {
    Cart cart = new Cart(customerId, storeId);
    cart.setStatus(status);
    cart.addItem(new CartItem(UUID.randomUUID(), null, storeId + " item", 2, new BigDecimal("10.00")));
    cart.setTotalAmount(new BigDecimal("20.00"));
    return cart;
  }

  @Test void returnsPersistedItemsFromEveryActiveStoreForOnlyTheOwner() throws Exception {
    UUID owner = UUID.randomUUID();
    Cart first = cart(owner, "A", CartStatus.ACTIVE);
    CartItem savedItem = new CartItem(UUID.randomUUID(), null, "Saved for later", 1, BigDecimal.ONE);
    savedItem.setStatus(CartItemStatus.SAVED_FOR_LATER);
    first.addItem(savedItem);
    carts.saveAllAndFlush(List.of(first, cart(owner, "B", CartStatus.ACTIVE),
      cart(owner, "checked-out", CartStatus.CHECKED_OUT), cart(owner, "abandoned", CartStatus.ABANDONED),
      cart(UUID.randomUUID(), "other-customer", CartStatus.ACTIVE)));

    mvc.perform(get("/api/v1/carts/customer/" + owner + "/active")
      .with(jwt().jwt(j -> j.claim("customerId", owner.toString()))))
      .andExpect(status().isOk())
      .andExpect(jsonPath("$.length()").value(2))
      .andExpect(jsonPath("$[*].storeId", containsInAnyOrder("A", "B")))
      .andExpect(jsonPath("$[*].items[*].productName", containsInAnyOrder("A item", "B item")))
      .andExpect(jsonPath("$[*].items[*].quantity", containsInAnyOrder(2, 2)))
      .andExpect(jsonPath("$[*].savedForLaterItems[*].productName", containsInAnyOrder("Saved for later")));
  }

  @Test void returnsAnEmptyArrayWhenTheCustomerHasNoActiveCarts() throws Exception {
    UUID owner = UUID.randomUUID();
    mvc.perform(get("/api/v1/carts/customer/" + owner + "/active")
      .with(jwt().jwt(j -> j.claim("customerId", owner.toString()))))
      .andExpect(status().isOk()).andExpect(content().json("[]"));
  }

  @Test void deniesGuestsOtherCustomersAndStaffWithoutCustomerOwnership() throws Exception {
    UUID owner = UUID.randomUUID();
    String path = "/api/v1/carts/customer/" + owner + "/active";
    mvc.perform(get(path)).andExpect(status().isUnauthorized());
    mvc.perform(get(path).with(jwt().jwt(j -> j.claim("customerId", UUID.randomUUID().toString()))))
      .andExpect(status().isForbidden());
    mvc.perform(get(path).with(jwt().authorities(new org.springframework.security.core.authority.SimpleGrantedAuthority("ROLE_ADMIN"))))
      .andExpect(status().isForbidden());
    mvc.perform(get(path).with(jwt().jwt(j -> j.claim("customerId", "invalid"))))
      .andExpect(status().isForbidden());
  }
}
