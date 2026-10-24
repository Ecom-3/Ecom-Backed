-- These demo orders were seeded as terminal states without matching
-- fulfillment-service records. Keep the demo rows, but return them to the
-- pre-shipment state until a real fulfillment and shipment are created.
UPDATE orders
SET status = 'PROCESSING',
    updated_at = NOW(6)
WHERE (id = UUID_TO_BIN('73000000-0000-0000-0000-000000000004')
       AND order_number = 'DEMO-BLR-2001'
       AND status = 'SHIPPED')
   OR (id = UUID_TO_BIN('73000000-0000-0000-0000-000000000005')
       AND order_number = 'DEMO-CHN-3001'
       AND status = 'DELIVERED');
