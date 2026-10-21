package com.metaarch.order.exception;

import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.context.request.ServletWebRequest;
import static org.assertj.core.api.Assertions.assertThat;

class GlobalEligibilityErrorTest {
  @Test void eligibilityIsValidationWhileDependencyFailureRemainsUnavailable() {
    var handler = new GlobalExceptionHandler();
    var request = new ServletWebRequest(new MockHttpServletRequest());
    var validation = handler.globalEligibility(new ProductNotGlobalEligibleException(), request);
    assertThat(validation.getStatusCode().value()).isEqualTo(422);
    assertThat(validation.getBody()).containsEntry("code", "PRODUCT_NOT_GLOBAL_ELIGIBLE");
    var unavailable = handler.deliveryQuoteUnavailable(new DeliveryQuoteVerificationException("Catalog unavailable", new RuntimeException()), request);
    assertThat(unavailable.getStatusCode().value()).isEqualTo(503);
  }
}