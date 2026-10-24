ALTER TABLE orders
  ADD COLUMN global_assigned_store_id VARCHAR(100) NULL,
  ADD COLUMN global_assigned_at TIMESTAMP(6) NULL;

CREATE INDEX idx_orders_global_assigned_store ON orders(global_assigned_store_id);
