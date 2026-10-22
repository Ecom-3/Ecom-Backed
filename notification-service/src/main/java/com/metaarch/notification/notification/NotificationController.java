package com.metaarch.notification.notification;

import java.net.URI;
import java.util.UUID;
import jakarta.validation.Valid;
import com.metaarch.notification.common.PageResponse;
import org.springframework.data.domain.*;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/notifications")
public class NotificationController {
  private final NotificationService service;
  public NotificationController(NotificationService service) { this.service = service; }

  @PostMapping public ResponseEntity<NotificationResponse> create(@Valid @RequestBody CreateNotificationRequest request) { NotificationResponse notification = service.create(request); return ResponseEntity.created(URI.create("/api/v1/notifications/" + notification.id())).body(notification); }
  @GetMapping("/{notificationId}") public NotificationResponse get(@PathVariable UUID notificationId) { return service.get(notificationId); }
  @org.springframework.security.access.prepost.PreAuthorize("@notificationAccess.customer(#customerId)")
  @GetMapping("/customer/{customerId}") public PageResponse<NotificationResponse> getByCustomer(@PathVariable UUID customerId, @PageableDefault(size = 100, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) { return service.getByCustomer(customerId, pageable); }
  @org.springframework.security.access.prepost.PreAuthorize("@notificationAccess.customer(#customerId)")
  @DeleteMapping("/customer/{customerId}/clear") public java.util.Map<String, Integer> clearByCustomer(@PathVariable UUID customerId) { return java.util.Map.of("clearedCount", service.clearByCustomer(customerId)); }
  @org.springframework.security.access.prepost.PreAuthorize("@notificationAccess.ownsNotification(#notificationId)")
  @PatchMapping("/{notificationId}/read") public NotificationResponse markRead(@PathVariable UUID notificationId, @org.springframework.security.core.annotation.AuthenticationPrincipal org.springframework.security.oauth2.jwt.Jwt token) { return service.markRead(UUID.fromString(token.getClaimAsString("customerId")), notificationId); }
  @GetMapping("/order/{orderId}") public PageResponse<NotificationResponse> getByOrder(@PathVariable UUID orderId, @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) { return service.getByOrder(orderId, pageable); }
  @GetMapping("/history") public PageResponse<NotificationResponse> history(@PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) { return service.history(pageable); }
  @PatchMapping("/{notificationId}/status") public NotificationResponse updateStatus(@PathVariable UUID notificationId, @Valid @RequestBody UpdateNotificationStatusRequest request) { return service.updateStatus(notificationId, request); }
  @PostMapping("/{notificationId}/send") public NotificationResponse send(@PathVariable UUID notificationId, @Valid @RequestBody(required = false) SendNotificationRequest request) { return service.send(notificationId, request); }
}
