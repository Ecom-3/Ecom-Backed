package com.metaarch.catalog.coupon;

import java.net.URI;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/coupons")
public class CouponController {
  private final CouponService service;
  public CouponController(CouponService service) { this.service = service; }

  @GetMapping List<CouponResponse> list() { return service.list(); }

  @PostMapping("/validate") CouponValidationResponse validate(@Valid @RequestBody CouponValidationRequest request) { return service.validate(request); }

  @PostMapping
  ResponseEntity<CouponResponse> create(@Valid @RequestBody CouponRequest request) {
    CouponResponse saved = service.create(request);
    return ResponseEntity.created(URI.create("/api/v1/coupons/" + saved.id())).body(saved);
  }

  @PutMapping("/{id}") CouponResponse update(@PathVariable UUID id, @Valid @RequestBody CouponRequest request) { return service.update(id, request); }

  @PatchMapping("/{id}/status") CouponResponse setStatus(@PathVariable UUID id, @RequestBody Map<String, String> body) {
    return service.setStatus(id, body == null ? null : body.get("status"));
  }

  @DeleteMapping("/{id}") @ResponseStatus(HttpStatus.NO_CONTENT) void delete(@PathVariable UUID id) { service.delete(id); }
}
