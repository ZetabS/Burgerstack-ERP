-- =========================================================
-- 99_check.sql
-- 역할:
--   - 시딩 후 검증 쿼리 실행
-- 확인 항목:
--   - 사용자/점포/자재 분포
--   - 안전재고 미만 재고
--   - 발주 상태 분포
--   - 발주 총액 정합성
--   - 자재 스냅샷명 정합성
--   - RECEIVED 발주의 입고/재고 변동 연결 여부
-- =========================================================

-- 사용자 역할별 조회
SELECT role, status, COUNT(*) AS cnt
  FROM users
 GROUP BY role, status
 ORDER BY role, status;

-- 점포 상태별 조회
SELECT status, COUNT(*) AS cnt
  FROM stores
 GROUP BY status
 ORDER BY status;

-- 자재 유형별 조회
SELECT material_type, COUNT(*) AS cnt
  FROM materials
 GROUP BY material_type
 ORDER BY material_type;

-- 안전재고 미만 재고
SELECT s.store_name,
       m.material_name,
       si.current_quantity,
       si.safety_quantity
  FROM store_inventories si
  JOIN stores s
    ON s.store_id = si.store_id
  JOIN materials m
    ON m.material_id = si.material_id
 WHERE si.current_quantity < si.safety_quantity
 ORDER BY s.store_id, m.material_id;

-- 발주 상태별 집계
SELECT status, COUNT(*) AS cnt
  FROM purchase_orders
 GROUP BY status
 ORDER BY status;

-- 발주 총액 정합성 검증(결과가 없어야 정상)
SELECT po.purchase_order_id,
       po.total_amount,
       SUM(poi.request_quantity * poi.supply_price_snapshot) AS calculated_amount,
       po.total_amount - SUM(poi.request_quantity * poi.supply_price_snapshot) AS diff
  FROM purchase_orders po
  JOIN purchase_order_items poi
    ON poi.purchase_order_id = po.purchase_order_id
 GROUP BY po.purchase_order_id, po.total_amount
HAVING po.total_amount <> SUM(poi.request_quantity * poi.supply_price_snapshot);

-- 발주 자재명 스냅샷 정합성 검증(결과가 없어야 정상)
SELECT poi.purchase_order_item_id,
       poi.material_id,
       m.material_name AS current_material_name,
       poi.material_name_snapshot
  FROM purchase_order_items poi
  JOIN materials m
    ON m.material_id = poi.material_id
 WHERE m.material_name <> poi.material_name_snapshot;

-- 발주와 입고 정합성 검증(결과가 없어야 정상)
SELECT po.purchase_order_id,
       po.status
  FROM purchase_orders po
 WHERE po.status = 'RECEIVED'
   AND NOT EXISTS (
       SELECT 1
         FROM receipts r
        WHERE r.purchase_order_id = po.purchase_order_id
   );

-- 발주와 입고 간 상세 품목 연결 정합성 검증
SELECT po.purchase_order_id,
       COUNT(ri.receipt_item_id) AS receipt_item_count,
       COUNT(itx_item.inventory_transaction_item_id) AS inventory_tx_item_count
  FROM purchase_orders po
  LEFT JOIN receipts r
    ON r.purchase_order_id = po.purchase_order_id
  LEFT JOIN receipt_items ri
    ON ri.receipt_id = r.receipt_id
  LEFT JOIN inventory_transactions itx
    ON itx.receipt_id = r.receipt_id
  LEFT JOIN inventory_transaction_items itx_item
    ON itx_item.inventory_transaction_id = itx.inventory_transaction_id
 WHERE po.status = 'RECEIVED'
 GROUP BY po.purchase_order_id;
