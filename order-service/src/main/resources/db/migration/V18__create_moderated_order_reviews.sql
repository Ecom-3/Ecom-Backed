-- V15/V16 already create the legacy order-level review table. Extend that table
-- so the moderation and product-review endpoints use the same persisted model.
-- Product fields remain nullable for pre-existing order-level review rows.
ALTER TABLE order_reviews
  ADD COLUMN product_id BINARY(16) NULL AFTER customer_id,
  ADD COLUMN product_name VARCHAR(255) NULL AFTER product_id,
  ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'PENDING' AFTER photo_urls,
  ADD COLUMN admin_reply VARCHAR(1000) NULL AFTER status,
  DROP INDEX order_id,
  ADD CONSTRAINT uk_order_reviews_order_product UNIQUE (order_id, product_id),
  ADD CONSTRAINT chk_order_reviews_status CHECK (status IN ('PENDING','APPROVED','REJECTED')),
  ADD INDEX idx_order_reviews_product_status_created (product_id, status, created_at),
  ADD INDEX idx_order_reviews_customer_created (customer_id, created_at),
  ADD INDEX idx_order_reviews_status_created (status, created_at);
