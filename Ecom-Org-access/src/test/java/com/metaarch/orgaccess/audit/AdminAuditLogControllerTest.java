package com.metaarch.orgaccess.audit;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import com.metaarch.orgaccess.config.SecurityConfig;
import com.metaarch.orgaccess.security.DatabaseUserDetailsService;
import com.metaarch.orgaccess.security.JwtTokenProvider;
import com.metaarch.orgaccess.security.OAuth2ProvisioningSuccessHandler;

@WebMvcTest(AdminAuditLogController.class)
@Import(SecurityConfig.class)
@org.springframework.test.context.TestPropertySource(properties = {"spring.cloud.config.enabled=false", "spring.cloud.config.import-check.enabled=false"})
class AdminAuditLogControllerTest {
  @Autowired MockMvc mvc;
  @MockBean AuditLogRepository logs;
  @MockBean JwtTokenProvider tokens;
  @MockBean DatabaseUserDetailsService users;
  @MockBean OAuth2ProvisioningSuccessHandler oauth2SuccessHandler;

  @Test
  @WithMockUser(username = "global-admin", authorities = {"ROLE_GLOBAL_ADMIN"})
  void globalAdminCanReadBoundedAuditProjection() throws Exception {
    var row = new AuditLog("qa-actor", "PROFILE_UPDATED", "qa-target");
    when(logs.findAll(any(org.springframework.data.jpa.domain.Specification.class), any(PageRequest.class)))
        .thenReturn(new PageImpl<>(List.of(row), PageRequest.of(0, 25), 1));
    mvc.perform(get("/api/audit-logs?page=0&size=25&actor=qa&sortBy=createdAt&direction=desc"))
        .andExpect(status().isOk()).andExpect(jsonPath("$.totalElements").value(1))
        .andExpect(jsonPath("$.content[0].actor").value("qa-actor"))
        .andExpect(jsonPath("$.content[0].action").value("PROFILE_UPDATED"))
        .andExpect(jsonPath("$.content[0].target").value("qa-target"))
        .andExpect(jsonPath("$.content[0].createdAt").exists())
        .andExpect(jsonPath("$.content[0].password").doesNotExist());
  }

  @Test
  @WithMockUser(authorities = {"ROLE_CUSTOMER"})
  void nonAdminCannotReadAuditLogs() throws Exception {
    mvc.perform(get("/api/audit-logs")).andExpect(status().isForbidden());
  }

  @Test
  @WithMockUser(authorities = {"ROLE_SUPER_ADMIN"})
  void rejectsUnsupportedSortFieldsAndUnboundedPages() throws Exception {
    mvc.perform(get("/api/audit-logs?sortBy=target")).andExpect(status().isBadRequest());
    mvc.perform(get("/api/audit-logs?size=101")).andExpect(status().isBadRequest());
  }
}
