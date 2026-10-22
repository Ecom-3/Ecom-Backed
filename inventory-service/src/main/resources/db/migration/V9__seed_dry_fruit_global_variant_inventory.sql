-- Keep global dry-fruit test variants purchasable with the same opening stock
-- quantity used by V8 for other global catalog variants.
INSERT INTO inventories (id, product_id, variant_id, variant_key, store_id,
                         available_quantity, reserved_quantity, reorder_level,
                         status, version, created_at, updated_at)
SELECT UUID_TO_BIN(UUID()), p.id, pv.id, pv.id, 'global-store',
       100, 0, 10, 'ACTIVE', 0, NOW(6), NOW(6)
FROM catalog_service.products p
JOIN catalog_service.product_variants pv
  ON pv.product_id = p.id AND pv.active = 1
WHERE p.sku IN ('DRY-CAL-ALMOND', 'DRY-PREM-CASHEW', 'DRY-AFG-RAISIN', 'DRY-IRN-PISTA', 'DRY-PREM-WALNUT')
  AND p.status = 'ACTIVE'
  AND (p.global_product = 1 OR p.fulfillment_type = 'global')
  AND NOT EXISTS (
    SELECT 1 FROM inventories i
    WHERE i.product_id = p.id AND i.variant_key = pv.id AND i.store_id = 'global-store'
  );
