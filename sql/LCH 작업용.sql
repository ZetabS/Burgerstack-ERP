COMMENT ON COLUMN RECEIPT_ITEMS.DEFECT_QUANTITY IS
    '불량 수량';
COMMIT;
-- 더미데이터 START--
INSERT INTO STORES(STORE_ID,
                   STORE_CODE,
                   STORE_NAME,
                   PHONE,
                   ADDRESS,
                   OWNER_USER_ID,
                   CREATED_BY,
                   UPDATED_BY,
                   UPDATED_AT)
           VALUES (00,
                   'S00',
                   '서울역',
                   '010-1111-1111',
                   '서울특별시 용산구 한강대로 405',
                   2,
                   1,
                   1,
                   SYSDATE);

INSERT INTO PURCHASE_REQUESTS(PURCHASE_REQUEST_ID,
                               STORE_ID,
                               STATUS,
                               TOTAL_AMOUNT,
                               REQUEST_MEMO,
                               CREATED_BY,
                               UPDATED_BY,
                               UPDATED_AT)
                       VALUES (0,
                               00,
                               'REQUESTED',
                               55,
                               '발주 더미데이터00',
                               2,
                               1,
                               SYSDATE);

INSERT INTO PURCHASE_REQUESTS(PURCHASE_REQUEST_ID,
                               STORE_ID,
                               STATUS,
                               TOTAL_AMOUNT,
                               REQUEST_MEMO,
                               CREATED_BY,
                               UPDATED_BY,
                               UPDATED_AT)
                       VALUES (1,
                               00,
                               'APPROVED',
                               55,
                               '발주 더미데이터00',
                               2,
                               1,
                               SYSDATE);

INSERT INTO RECEIPTS
     VALUES(999, 00, 00, 'DUMMY_DATA_RECEIPTS00', 2, SYSDATE); 
-- 더미데이터 END --

---------------------------------------

-- 입고이력 목록 페이지 수 
SELECT COUNT(*)
  FROM RECEIPTS
 WHERE STORE_ID = ?;
 
-- 입고예정 목록 페이지 수
SELECT COUNT(*)
  FROM PURCHASE_REQUESTS
 WHERE STATUS = 'APPROVED' || 'PARTIALLY_APPROVED' -- APPROVED : 승인
   AND STORE_ID = ?;
   
-- 입고예정 목록 조회
-- 발주 번호, 상태, 품목요약, 총액, 요청일
SELECT PR.PURCHASE_REQUEST_ID,
       PR.STATUS,
       --품목요약,
       PRITEM.SUBTOTAL_AMOUNT,
       PR.CREATED_AT,
       PR.UPDATED_AT
  FROM PURCHASE_REQUESTS PR
  JOIN PURCHASE_REQUEST_ITEMS PRITEM
    ON PR.PURCHASE_REQUEST_ID = PRITEM.PURCHASE_REQUEST_ID
       