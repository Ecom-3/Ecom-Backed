SET @legacy_check = (
  SELECT CONSTRAINT_NAME FROM information_schema.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE() AND TABLE_NAME = 'fulfillment_order_snapshots'
    AND CONSTRAINT_TYPE = 'CHECK' AND CONSTRAINT_NAME = 'fulfillment_order_snapshots_chk_1'
  LIMIT 1
);
SET @ddl = IF(@legacy_check IS NULL, 'SELECT 1',
  CONCAT('ALTER TABLE fulfillment_order_snapshots DROP CHECK `', @legacy_check, '`'));
PREPARE migration_stmt FROM @ddl;
EXECUTE migration_stmt;
DEALLOCATE PREPARE migration_stmt;

SET @has_check = (
  SELECT COUNT(*) FROM information_schema.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE() AND TABLE_NAME = 'fulfillment_order_snapshots'
    AND CONSTRAINT_TYPE = 'CHECK' AND CONSTRAINT_NAME = 'chk_fulfillment_order_snapshot_type'
);
SET @ddl = IF(@has_check > 0, 'SELECT 1',
  'ALTER TABLE fulfillment_order_snapshots ADD CONSTRAINT chk_fulfillment_order_snapshot_type CHECK (fulfillment_type IN (''SHIP_TO_HOME'', ''STORE_PICKUP'', ''GLOBAL'', ''DIGITAL''))');
PREPARE migration_stmt FROM @ddl;
EXECUTE migration_stmt;
DEALLOCATE PREPARE migration_stmt;

SET @legacy_check = (
  SELECT CONSTRAINT_NAME FROM information_schema.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE() AND TABLE_NAME = 'fulfillments'
    AND CONSTRAINT_TYPE = 'CHECK' AND CONSTRAINT_NAME = 'fulfillments_chk_1'
  LIMIT 1
);
SET @ddl = IF(@legacy_check IS NULL, 'SELECT 1',
  CONCAT('ALTER TABLE fulfillments DROP CHECK `', @legacy_check, '`'));
PREPARE migration_stmt FROM @ddl;
EXECUTE migration_stmt;
DEALLOCATE PREPARE migration_stmt;

SET @has_check = (
  SELECT COUNT(*) FROM information_schema.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE() AND TABLE_NAME = 'fulfillments'
    AND CONSTRAINT_TYPE = 'CHECK' AND CONSTRAINT_NAME = 'chk_fulfillment_type'
);
SET @ddl = IF(@has_check > 0, 'SELECT 1',
  'ALTER TABLE fulfillments ADD CONSTRAINT chk_fulfillment_type CHECK (fulfillment_type IN (''SHIP_TO_HOME'', ''STORE_PICKUP'', ''GLOBAL'', ''DIGITAL''))');
PREPARE migration_stmt FROM @ddl;
EXECUTE migration_stmt;
DEALLOCATE PREPARE migration_stmt;
