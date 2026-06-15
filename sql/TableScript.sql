-- =========================================================
-- demo_all.sql
-- 역할:
--   - 데모 DB 전체 구성용 통합 실행 파일
-- 실행 순서:
--   - 00_drop.sql
--   - 01_schema.sql
--   - 10_seed_base.sql
--   - 20_seed_purchase.sql
--   - 30_seed_receipt.sql
--   - 40_seed_inventory_transaction.sql
--   - 50_seed_closing.sql
--   - 60_seed_notice_inquiry.sql
--   - 99_check.sql
-- =========================================================

@@00_drop.sql
@@01_schema.sql
@@10_seed_base.sql
@@20_seed_purchase.sql
@@30_seed_receipt.sql
@@40_seed_inventory_transaction.sql
@@50_seed_closing.sql
@@60_seed_notice_inquiry.sql
@@99_check.sql

COMMIT;
