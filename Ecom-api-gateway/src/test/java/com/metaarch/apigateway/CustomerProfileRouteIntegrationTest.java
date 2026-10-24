package com.metaarch.apigateway;

import static org.assertj.core.api.Assertions.assertThat;

import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.concurrent.atomic.AtomicReference;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT, properties = {
    "spring.profiles.active=integration",
    "spring.config.import=",
    "spring.cloud.config.enabled=false",
    "spring.cloud.discovery.enabled=false",
    "eureka.client.enabled=false",
    "spring.main.log-startup-info=false",
    "logging.level.root=ERROR"
})
class CustomerProfileRouteIntegrationTest {
  private static final AtomicReference<String> lastAuthorization = new AtomicReference<>();
  private static final HttpServer customerProfileStub = startCustomerProfileStub();

  @LocalServerPort int gatewayPort;

  @DynamicPropertySource
  static void gatewayProperties(DynamicPropertyRegistry properties) {
    properties.add("spring.cloud.gateway.routes[0].id", () -> "customer-profile-test");
    properties.add("spring.cloud.gateway.routes[0].uri",
        () -> "http://127.0.0.1:" + customerProfileStub.getAddress().getPort());
    properties.add("spring.cloud.gateway.routes[0].predicates[0]", () -> "Path=/customer-profile/**");
    properties.add("spring.cloud.gateway.routes[0].filters[0]", () -> "StripPrefix=1");
  }

  @Test
  void forwardsSuperAdminRequestAndPreservesServiceDenialForCustomerRole() throws Exception {
    var client = HttpClient.newHttpClient();
    var superAdminResponse = get(client, "ROLE_SUPER_ADMIN");

    assertThat(superAdminResponse.statusCode()).isEqualTo(200);
    assertThat(lastAuthorization.get()).startsWith("Bearer ");
    assertThat(superAdminResponse.body()).contains("\"content\":[]");

    var customerResponse = get(client, "ROLE_CUSTOMER");
    assertThat(customerResponse.statusCode()).isEqualTo(403);
    assertThat(lastAuthorization.get()).startsWith("Bearer ");
  }

  private HttpResponse<String> get(HttpClient client, String role) throws Exception {
    String token = testToken(role);
    return client.send(HttpRequest.newBuilder(URI.create("http://127.0.0.1:" + gatewayPort
        + "/customer-profile/api/v1/admin/customers?page=0&size=25"))
        .header("Authorization", "Bearer " + token)
        .GET().build(), HttpResponse.BodyHandlers.ofString());
  }

  @AfterAll
  static void stopCustomerProfileStub() {
    customerProfileStub.stop(0);
  }

  private static HttpServer startCustomerProfileStub() {
    try {
      var server = HttpServer.create(new InetSocketAddress("127.0.0.1", 0), 0);
      server.createContext("/api/v1/admin/customers", exchange -> {
        String authorization = exchange.getRequestHeaders().getFirst("Authorization");
        lastAuthorization.set(authorization);
        int status = hasSuperAdminRole(authorization) ? 200 : 403;
        String response = status == 200
            ? "{\"content\":[],\"page\":0,\"size\":25,\"totalElements\":0,\"totalPages\":0}"
            : "{\"error\":\"forbidden\"}";
        byte[] body = response.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().add("Content-Type", "application/json");
        exchange.sendResponseHeaders(status, body.length);
        try (var output = exchange.getResponseBody()) { output.write(body); }
      });
      server.start();
      return server;
    } catch (IOException error) {
      throw new ExceptionInInitializerError(error);
    }
  }

  private static boolean hasSuperAdminRole(String authorization) {
    if (authorization == null || !authorization.startsWith("Bearer ")) return false;
    try {
      String[] parts = authorization.substring("Bearer ".length()).split("\\.");
      String claims = new String(Base64.getUrlDecoder().decode(parts[1]), StandardCharsets.UTF_8);
      return claims.contains("\"ROLE_SUPER_ADMIN\"");
    } catch (RuntimeException malformedToken) {
      return false;
    }
  }

  private static String testToken(String role) {
    String header = Base64.getUrlEncoder().withoutPadding()
        .encodeToString("{\"alg\":\"none\"}".getBytes(StandardCharsets.UTF_8));
    String claims = Base64.getUrlEncoder().withoutPadding()
        .encodeToString(("{\"sub\":\"qa-super-admin\",\"roles\":[\"" + role + "\"]}")
            .getBytes(StandardCharsets.UTF_8));
    return header + "." + claims + ".test-signature";
  }
}
