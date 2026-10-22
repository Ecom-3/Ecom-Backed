INSERT INTO coupons (
  id, code, coupon_name, description, discount_type, discount, minimum_order,
  maximum_discount, start_date, expiry, usage_limit, per_user_limit, scope,
  location, store, product, category, eligibility, status, created_at, updated_at
)
VALUES
  (UUID_TO_BIN(UUID()), 'TEST10', 'Test 10 Percent', 'Test coupon for checkout validation', 'PERCENTAGE', 10.00, 500.00,
   250.00, CURRENT_DATE(), '2030-12-31', 1000, 5, 'GLOBAL', NULL, NULL, NULL, NULL, 'All customers', 'ACTIVE', NOW(6), NOW(6)),
  (UUID_TO_BIN(UUID()), 'TEST100', 'Test 100 Rupees', 'Test fixed amount coupon for checkout validation', 'FIXED', 100.00, 500.00,
   NULL, CURRENT_DATE(), '2030-12-31', 1000, 5, 'GLOBAL', NULL, NULL, NULL, NULL, 'All customers', 'ACTIVE', NOW(6), NOW(6))
ON DUPLICATE KEY UPDATE
  coupon_name = VALUES(coupon_name),
  description = VALUES(description),
  status = 'ACTIVE',
  updated_at = NOW(6);
