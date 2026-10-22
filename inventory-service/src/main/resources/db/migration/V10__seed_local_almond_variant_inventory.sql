-- Give each active California Almonds pack its own opening stock at mapped
-- local stores. Existing inventory is left untouched; missing rows are added
-- with the same 50-unit opening quantity used by V8.
INSERT INTO inventories (id, product_id, variant_id, variant_key, store_id,
                         available_quantity, reserved_quantity, reorder_level,
                         status, version, created_at, updated_at)
SELECT UUID_TO_BIN(UUID()), sp.product_id, pv.id, pv.id, sp.store_id,
       50, 0, 10, 'ACTIVE', 0, NOW(6), NOW(6)
FROM catalog_service.store_products sp
JOIN catalog_service.products p
  ON p.id = sp.product_id
JOIN catalog_service.product_variants pv
  ON pv.product_id = p.id AND pv.active = 1
WHERE p.sku = 'DRY-CAL-ALMOND'
  AND p.status = 'ACTIVE'
  AND sp.available = 1
  AND sp.store_id <> 'global-store'
  AND NOT EXISTS (
    SELECT 1
    FROM inventories i
    WHERE i.product_id = sp.product_id
      AND i.variant_key = pv.id
      AND i.store_id = sp.store_id
  );
