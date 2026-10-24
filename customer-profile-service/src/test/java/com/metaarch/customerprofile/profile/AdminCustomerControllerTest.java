package com.metaarch.customerprofile.profile;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.jwt;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.time.Instant;
import java.util.UUID;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

@SpringBootTest
@AutoConfigureMockMvc
class AdminCustomerControllerTest {
  @Autowired MockMvc mvc;
  @Autowired CustomerProfileRepository profiles;

  @Test
  @Transactional
  void superAdminCanReadPaginatedCustomerSummariesWithoutPrivateProfileFields() throws Exception {
    var first = profiles.save(profile("qa-customer-a"));
    var second = profiles.save(profile("qa-customer-b"));
    var third = profiles.save(profile("qa-customer-c"));
    long total = profiles.count();

    String pageZero = mvc.perform(get("/api/v1/admin/customers?page=0&size=2")
        .with(jwt().authorities(() -> "ROLE_SUPER_ADMIN")))
        .andExpect(status().isOk()).andExpect(contentTypeJson())
        .andExpect(jsonPath("$.page").value(0)).andExpect(jsonPath("$.size").value(2))
        .andExpect(jsonPath("$.totalElements").value(total)).andExpect(jsonPath("$.totalPages").value((int) Math.ceil(total / 2.0)))
        .andReturn().getResponse().getContentAsString();
    org.assertj.core.api.Assertions.assertThat(pageZero).doesNotContain("photo", "dateOfBirth", "gender");

    String pageOne = mvc.perform(get("/api/v1/admin/customers?page=1&size=2")
        .with(jwt().authorities(() -> "ROLE_SUPER_ADMIN")))
        .andExpect(status().isOk()).andExpect(jsonPath("$.page").value(1))
        .andExpect(jsonPath("$.content.length()").value(1)).andReturn().getResponse().getContentAsString();
    org.assertj.core.api.Assertions.assertThat(pageZero + pageOne)
        .contains(first.getId().toString(), second.getId().toString(), third.getId().toString());
  }

  @Test
  void nonAdminCannotReadCustomerCollection() throws Exception {
    mvc.perform(get("/api/v1/admin/customers").with(jwt().authorities(() -> "ROLE_CUSTOMER")))
        .andExpect(status().isForbidden());
  }

  @Test
  void globalAdminCanReadCollectionButCustomerCannot() throws Exception {
    mvc.perform(get("/api/v1/admin/customers?page=0&size=1")
        .with(jwt().authorities(() -> "ROLE_GLOBAL_ADMIN")))
        .andExpect(status().isOk()).andExpect(jsonPath("$.page").value(0));
    mvc.perform(get("/api/v1/admin/customers")
        .with(jwt().authorities(() -> "ROLE_CUSTOMER")))
        .andExpect(status().isForbidden());
    mvc.perform(post("/api/v1/admin/customers")
        .with(jwt().authorities(() -> "ROLE_GLOBAL_ADMIN")))
        .andExpect(status().isMethodNotAllowed());
  }

  @Test
  void rejectsInvalidPaginationParameters() throws Exception {
    mvc.perform(get("/api/v1/admin/customers?page=-1&size=101")
        .with(jwt().authorities(() -> "ROLE_SUPER_ADMIN")))
        .andExpect(status().isBadRequest());
  }

  private CustomerProfile profile(String username) {
    var profile = new CustomerProfile(username, "QA " + username, "+919876543210");
    profile.setId(UUID.randomUUID());
    return profile;
  }

  private org.springframework.test.web.servlet.ResultMatcher contentTypeJson() {
    return result -> org.assertj.core.api.Assertions.assertThat(result.getResponse().getContentType())
        .startsWith(MediaType.APPLICATION_JSON_VALUE);
  }
}
