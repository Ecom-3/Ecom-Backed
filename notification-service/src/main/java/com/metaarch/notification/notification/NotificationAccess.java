package com.metaarch.notification.notification;

import com.metaarch.sync.PublicApiSecurity;
import java.util.UUID;
import org.springframework.context.annotation.Import;
import org.springframework.stereotype.Component;

@Component("notificationAccess")
@Import(PublicApiSecurity.class)
public class NotificationAccess {
  private final NotificationRepository notifications;
  public NotificationAccess(NotificationRepository notifications) { this.notifications = notifications; }

  public boolean customer(UUID customerId) { return PublicApiSecurity.owns(customerId); }
  public boolean ownsNotification(UUID notificationId) {
    return notificationId != null && notifications.findById(notificationId).map(item -> PublicApiSecurity.owns(item.getCustomerId())).orElse(false);
  }
}
