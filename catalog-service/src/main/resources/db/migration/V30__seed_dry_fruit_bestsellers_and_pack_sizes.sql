-- Use the complete existing dry-fruit catalog records as category bestsellers.
UPDATE products
SET best_seller = TRUE, updated_at = NOW(6)
WHERE sku IN ('DRY-PREM-CASHEW', 'DRY-AFG-RAISIN', 'DRY-IRN-PISTA', 'DRY-PREM-WALNUT');

-- Add the larger pack sizes used by the product detail demo. Stable SKUs make
-- the seed safe to reapply to databases that already have some of the rows.
INSERT INTO product_variants(id, product_id, sku, name, attributes, price, compare_at_price, active, created_at, updated_at)
SELECT UUID_TO_BIN(UUID()), p.id, sizes.variant_sku, sizes.variant_name,
       JSON_OBJECT('weight', sizes.variant_name, 'type', p.type),
       sizes.price, sizes.compare_at_price, TRUE, NOW(6), NOW(6)
FROM products p
JOIN (
  SELECT 'DRY-PREM-CASHEW' product_sku, 'DRY-PREM-CASHEW-500G' variant_sku, '500 g' variant_name, 699.00 price, 779.00 compare_at_price UNION ALL
  SELECT 'DRY-PREM-CASHEW', 'DRY-PREM-CASHEW-1KG', '1 kg', 1349.00, 1499.00 UNION ALL
  SELECT 'DRY-AFG-RAISIN', 'DRY-AFG-RAISIN-500G', '500 g', 389.00, 439.00 UNION ALL
  SELECT 'DRY-AFG-RAISIN', 'DRY-AFG-RAISIN-1KG', '1 kg', 749.00, 829.00 UNION ALL
  SELECT 'DRY-IRN-PISTA', 'DRY-IRN-PISTA-500G', '500 g', 779.00, 869.00 UNION ALL
  SELECT 'DRY-IRN-PISTA', 'DRY-IRN-PISTA-1KG', '1 kg', 1499.00, 1649.00 UNION ALL
  SELECT 'DRY-PREM-WALNUT', 'DRY-PREM-WALNUT-500G', '500 g', 629.00, 699.00 UNION ALL
  SELECT 'DRY-PREM-WALNUT', 'DRY-PREM-WALNUT-1KG', '1 kg', 1199.00, 1329.00
) sizes ON sizes.product_sku = p.sku
WHERE NOT EXISTS (
  SELECT 1 FROM product_variants v WHERE v.sku = sizes.variant_sku
);
