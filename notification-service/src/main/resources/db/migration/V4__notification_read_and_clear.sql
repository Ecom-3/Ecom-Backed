ALTER TABLE notifications
  ADD COLUMN read_at TIMESTAMP(6) NULL,
  ADD COLUMN cleared_at TIMESTAMP(6) NULL,
  ADD INDEX idx_notifications_customer_cleared (customer_id, cleared_at, created_at);
