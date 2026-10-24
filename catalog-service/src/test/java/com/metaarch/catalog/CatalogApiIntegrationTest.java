package com.metaarch.catalog;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import com.fasterxml.jackson.databind.JsonNode; import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test; import org.springframework.beans.factory.annotation.Autowired; import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc; import org.springframework.boot.test.context.SpringBootTest; import org.springframework.http.MediaType; import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.jwt;

@SpringBootTest(properties = "app.jwt.secret=local-isolated-test-secret-that-is-long-enough-for-hmac-sha256") @AutoConfigureMockMvc
class CatalogApiIntegrationTest {
 @Autowired MockMvc mvc; @Autowired ObjectMapper json;
 @Test void catalogCrudAndValidationRules() throws Exception {
  mvc.perform(post("/api/v1/stores").contentType(MediaType.APPLICATION_JSON).content("""
    {"id":"store-client-demo","name":"Client Demo Store","location":"Hyderabad","address":"Ameerpet, Hyderabad, Telangana, India","latitude":17.4375000,"longitude":78.4482000,"provider":"OPENSTREETMAP","providerPlaceId":"demo-place","deliveryEnabled":true,"pickupEnabled":true,"active":true}
    """)).andExpect(status().isCreated()).andExpect(jsonPath("$.id").value("store-client-demo")).andExpect(jsonPath("$.latitude").value(17.4375000));
  mvc.perform(get("/api/v1/stores").param("active","true")).andExpect(status().isOk()).andExpect(jsonPath("$[0].id").exists());
  JsonNode category=json.readTree(mvc.perform(post("/api/v1/categories").contentType(MediaType.APPLICATION_JSON).content("""
    {"name":"Phones","slug":"phones","description":"Mobile phones","active":true}
    """)).andExpect(status().isCreated()).andExpect(jsonPath("$.slug").value("phones")).andReturn().getResponse().getContentAsString());
  String categoryId=category.get("id").asText();
  JsonNode product=json.readTree(mvc.perform(post("/api/v1/products").contentType(MediaType.APPLICATION_JSON).content("""
    {"categoryId":"%s","name":"Example Phone","slug":"example-phone","sku":"PHONE-001","description":"Example","brand":"MetaArch","status":"ACTIVE"}
    """.formatted(categoryId))).andExpect(status().isCreated()).andExpect(jsonPath("$.categoryId").value(categoryId)).andReturn().getResponse().getContentAsString());
  String productId=product.get("id").asText();
  mvc.perform(post("/api/v1/products/{id}/variants",productId).contentType(MediaType.APPLICATION_JSON).content("""
    {"sku":"PHONE-001-BLK","name":"Black","price":500.00,"compareAtPrice":400.00,"active":true}
    """)).andExpect(status().isBadRequest()).andExpect(jsonPath("$.message").value("compareAtPrice must be greater than or equal to price"));
  JsonNode mapping=json.readTree(mvc.perform(post("/api/v1/store-products").with(jwt().authorities(() -> "ROLE_GLOBAL_ADMIN")).contentType(MediaType.APPLICATION_JSON).content("""
    {"storeId":"store-1","productId":"%s","available":true,"priceOverride":475.00}
    """.formatted(productId))).andExpect(status().isCreated()).andExpect(jsonPath("$.available").value(true)).andReturn().getResponse().getContentAsString());
  String mappingId=mapping.get("id").asText();
  mvc.perform(get("/api/v1/store-products/{id}",mappingId)).andExpect(status().isOk()).andExpect(jsonPath("$.priceOverride").value(475.00));
  mvc.perform(put("/api/v1/store-products/{id}",mappingId).with(jwt().authorities(() -> "ROLE_GLOBAL_ADMIN")).contentType(MediaType.APPLICATION_JSON).content("""
    {"storeId":"store-1","productId":"%s","available":false,"priceOverride":450.00}
    """.formatted(productId))).andExpect(status().isOk()).andExpect(jsonPath("$.available").value(false));
  mvc.perform(get("/api/v1/store-products").param("productId",productId)).andExpect(status().isOk()).andExpect(jsonPath("$[0].available").value(false)).andExpect(jsonPath("$[0].priceOverride").value(450.00));
  mvc.perform(post("/api/v1/store-products").with(jwt().authorities(() -> "ROLE_SUPER_ADMIN")).contentType(MediaType.APPLICATION_JSON).content("""
    {"storeId":"store-1","productId":"%s","available":true}
    """.formatted(productId))).andExpect(status().isConflict());
  mvc.perform(delete("/api/v1/store-products/{id}",mappingId).with(jwt().authorities(() -> "ROLE_SUPER_ADMIN"))).andExpect(status().isNoContent());
  mvc.perform(get("/api/v1/store-products").param("productId",productId)).andExpect(status().isOk()).andExpect(jsonPath("$").isEmpty());
  mvc.perform(delete("/api/v1/categories/{id}",categoryId)).andExpect(status().isConflict());
  mvc.perform(get("/api/v1/products").param("status","ACTIVE")).andExpect(status().isOk()).andExpect(jsonPath("$.totalElements").value(1));
 }

 @Test void mappingWritesRequireAdminOrTheManagerAssignedToTheTargetStore() throws Exception {
  String body="{\"storeId\":\"store-qa\",\"productId\":\"00000000-0000-0000-0000-000000000001\",\"available\":true}";
  mvc.perform(post("/api/v1/store-products").contentType(MediaType.APPLICATION_JSON).content(body)).andExpect(status().isUnauthorized());
  mvc.perform(post("/api/v1/store-products").with(jwt().authorities(() -> "ROLE_CUSTOMER")).contentType(MediaType.APPLICATION_JSON).content(body)).andExpect(status().isForbidden());
  mvc.perform(post("/api/v1/store-products").with(jwt().authorities(() -> "ROLE_STORE_MANAGER", () -> "SCOPE_STORE:store-other")).contentType(MediaType.APPLICATION_JSON).content(body)).andExpect(status().isForbidden());
  mvc.perform(post("/api/v1/store-products").with(jwt().authorities(() -> "ROLE_STORE_MANAGER", () -> "SCOPE_STORE:store-qa")).contentType(MediaType.APPLICATION_JSON).content(body)).andExpect(status().isNotFound());
 }

 @Test void rejectsInvalidCategorySlug() throws Exception {
  mvc.perform(post("/api/v1/categories").contentType(MediaType.APPLICATION_JSON).content("""
    {"name":"Bad slug","slug":"Bad Slug","active":true}
    """)).andExpect(status().isBadRequest()).andExpect(jsonPath("$.fields.slug").exists());
 }
}
