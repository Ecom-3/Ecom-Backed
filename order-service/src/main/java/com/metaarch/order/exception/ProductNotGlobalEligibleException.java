package com.metaarch.order.exception;

public class ProductNotGlobalEligibleException extends DeliveryQuoteVerificationException {
  public ProductNotGlobalEligibleException() { super("Product is not eligible for global delivery."); }
}