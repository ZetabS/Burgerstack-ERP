-- GPT 작성 데이터 무결성 장담못함
-- 테스트용으로만 사용할 것
-- 실행 전 기준 스키마는 core/01_schema.sql 기준으로 맞춰둘 것

-- 260602 - 이창현
-- 더미데이터 수정

-- 260608 - 이창현
-- 테이블 스크립트 업데이트에 따른 더미데이터 수정
-- 테이블스크립트에 더미 데이터 포함되있어 유저, 점포 더미데이터 삭제


--------------------------------------------------------
-- MATERIALS 60건
--------------------------------------------------------
BEGIN
    FOR I IN 1..60 LOOP

        INSERT INTO MATERIALS (
            MATERIAL_ID,
            MATERIAL_CODE,
            MATERIAL_NAME,
            MATERIAL_TYPE,
            SUPPLY_PRICE,
            DETAILS,
            STATUS,
            CREATED_AT,
            UPDATED_AT
        )
        VALUES (
            SEQ_MATERIAL.NEXTVAL,
            'MAT' || LPAD(I, 3, '0'),
            '자재' || I,
            CASE MOD(I,5)
                WHEN 0 THEN '육류'
                WHEN 1 THEN '채소'
                WHEN 2 THEN '소스'
                WHEN 3 THEN '음료'
                ELSE '포장재'
            END,
            500 + (I * 100),
            '더미 자재 데이터 ' || I,
            'ACTIVE',
            SYSDATE - MOD(I,30),
            NULL
        );

    END LOOP;
END;
/

--------------------------------------------------------
-- MATERIAL_FILES 60건
--------------------------------------------------------
BEGIN

    FOR I IN 1..60 LOOP

        INSERT INTO MATERIAL_FILES (
            MATERIAL_FILE_ID,
            ORIGINAL_NAME,
            STORED_NAME,
            STORAGE_PATH,
            CREATED_AT,
            DELETED_AT,
            MATERIAL_ID
        )
        VALUES (
            SEQ_MAT_FILE.NEXTVAL,
            'material_' || I || '.jpg',
            LOWER(RAWTOHEX(SYS_GUID())) || '.jpg',
            '/upload/material',
            SYSDATE,
            NULL,
            I
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- STORE_INVENTORIES 60건
--
-- STORE 1 : MATERIAL 1~20
-- STORE 2 : MATERIAL 21~40
-- STORE 3 : MATERIAL 41~60
--
-- UNIQUE(STORE_ID,MATERIAL_ID) 충돌 없음
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO STORE_INVENTORIES (
            STORE_INVENTORY_ID,
            CURRENT_QUANTITY,
            SAFETY_QUANTITY,
            CREATED_AT,
            UPDATED_AT,
            STORE_ID,
            MATERIAL_ID
        )
        VALUES (
            SEQ_STORE_INV.NEXTVAL,
            100 + I,
            30,
            SYSDATE,
            NULL,
            1,
            I
        );

    END LOOP;

    FOR I IN 21..40 LOOP

        INSERT INTO STORE_INVENTORIES (
            STORE_INVENTORY_ID,
            CURRENT_QUANTITY,
            SAFETY_QUANTITY,
            CREATED_AT,
            UPDATED_AT,
            STORE_ID,
            MATERIAL_ID
        )
        VALUES (
            SEQ_STORE_INV.NEXTVAL,
            100 + I,
            30,
            SYSDATE,
            NULL,
            2,
            I
        );

    END LOOP;

    FOR I IN 41..60 LOOP

        INSERT INTO STORE_INVENTORIES (
            STORE_INVENTORY_ID,
            CURRENT_QUANTITY,
            SAFETY_QUANTITY,
            CREATED_AT,
            UPDATED_AT,
            STORE_ID,
            MATERIAL_ID
        )
        VALUES (
            SEQ_STORE_INV.NEXTVAL,
            100 + I,
            30,
            SYSDATE,
            NULL,
            3,
            I
        );

    END LOOP;

END;
/



-- 입력 중간 점검
-- COMMIT;

-- SELECT COUNT(*) FROM MATERIALS;
-- 60

-- SELECT COUNT(*) FROM MATERIAL_FILES;
-- 60

-- SELECT COUNT(*) FROM STORE_INVENTORIES;
-- 60

--------------------------------------------------------
-- PURCHASE_ORDERS 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO PURCHASE_ORDERS (
            PURCHASE_ORDER_ID,
            TOTAL_AMOUNT,
            ORDER_MEMO,
            STATUS,
            CREATED_AT,
            UPDATED_AT,
            STORE_ID
        )
        VALUES (
            SEQ_PUR_REQ.NEXTVAL,
            100000 + (I * 5000),
            '더미 발주 ' || I,
            CASE MOD(I,5)
                WHEN 0 THEN 'REQUESTED'
                WHEN 1 THEN 'APPROVED'
                WHEN 2 THEN 'PARTIALLY_APPROVED'
                WHEN 3 THEN 'REJECTED'
                ELSE 'RECEIVED'
            END,
            SYSDATE - I,
            NULL,
            MOD(I-1,3)+1
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- PURCHASE_ORDER_ITEMS 40건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO PURCHASE_ORDER_ITEMS (
            PURCHASE_ORDER_ITEM_ID,
            REQUEST_QUANTITY,
            APPROVED_QUANTITY,
            REJECT_REASON,
            MATERIAL_NAME_SNAPSHOT,
            SUPPLY_PRICE_SNAPSHOT,
            MATERIAL_ID,
            PURCHASE_ORDER_ID
        )
        VALUES (
            SEQ_PUR_REQ_ITEM.NEXTVAL,
            50,
            50,
            NULL,
            '자재' || ((I*2)-1),
            1000,
            ((I*2)-1),
            I
        );

        INSERT INTO PURCHASE_ORDER_ITEMS (
            PURCHASE_ORDER_ITEM_ID,
            REQUEST_QUANTITY,
            APPROVED_QUANTITY,
            REJECT_REASON,
            MATERIAL_NAME_SNAPSHOT,
            SUPPLY_PRICE_SNAPSHOT,
            MATERIAL_ID,
            PURCHASE_ORDER_ID
        )
        VALUES (
            SEQ_PUR_REQ_ITEM.NEXTVAL,
            30,
            30,
            NULL,
            '자재' || (I*2),
            1200,
            (I*2),
            I
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- PURCHASE_ORDER_HISTORIES 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO PURCHASE_ORDER_HISTORIES (
            PURCHASE_ORDER_HISTORY_ID,
            TO_STATUS,
            REASON,
            CREATED_AT,
            CREATED_BY,
            PURCHASE_ORDER_ID
        )
        VALUES (
            SEQ_PUR_REQ_HIST.NEXTVAL,
            'APPROVED',
            '자동 생성 이력',
            SYSDATE - I,
            1,
            I
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- RECEIPTS 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO RECEIPTS (
            RECEIPT_ID,
            RECEIPT_MEMO,
            RECEIVED_AT,
            PURCHASE_ORDER_ID
        )
        VALUES (
            SEQ_RECEIPT.NEXTVAL,
            '정상 입고',
            SYSDATE - I,
            I
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- RECEIPT_ITEMS 40건
--------------------------------------------------------
BEGIN

    FOR I IN 1..40 LOOP

        INSERT INTO RECEIPT_ITEMS (
            RECEIPT_ITEM_ID,
            RECEIVED_QUANTITY,
            DEFECT_QUANTITY,
            RECEIPT_ITEM_MEMO,
            RECEIPT_ID,
            PURCHASE_ORDER_ITEM_ID
        )
        VALUES (
            SEQ_RECEIPT_ITEM.NEXTVAL,
            95,
            5,
            '정상 입고 처리',
            CEIL(I/2),
            I
        );

    END LOOP;

END;
/



-- 중간점검
-- COMMIT;

-- SELECT COUNT(*) FROM PURCHASE_ORDERS;
-- 20

-- SELECT COUNT(*) FROM PURCHASE_ORDER_ITEMS;
-- 40

-- SELECT COUNT(*) FROM PURCHASE_ORDER_HISTORIES;
-- 20

-- SELECT COUNT(*) FROM RECEIPTS;
-- 20

-- SELECT COUNT(*) FROM RECEIPT_ITEMS;
-- 40

--------------------------------------------------------
-- STORE_CLOSINGS 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO STORE_CLOSINGS (
            STORE_CLOSING_ID,
            BUSINESS_DATE,
            CLOSING_MEMO,
            CLOSED_AT,
            STORE_ID
        )
        VALUES (
            SEQ_STORE_CLS.NEXTVAL,
            DATE '2025-01-01' + I,
            '일일 마감 ' || I,
            SYSDATE - I,
            MOD(I-1,3)+1
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- STORE_CLOSING_ITEMS 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO STORE_CLOSING_ITEMS (
            STORE_CLOSING_ITEM_ID,
            SYSTEM_QUANTITY,
            PHYSICAL_QUANTITY,
            DISPOSAL_QUANTITY,
            CLOSING_ITEM_MEMO,
            MATERIAL_NAME_SNAPSHOT,
            STORE_CLOSING_ID,
            STORE_INVENTORY_ID
        )
        VALUES (
            SEQ_STORE_CLS_ITEM.NEXTVAL,
            100,
            98,
            2,
            '마감 처리',
            '자재' || I,
            I,
            I
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- INVENTORY_TRANSACTIONS 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO INVENTORY_TRANSACTIONS (
            INVENTORY_TRANSACTION_ID,
            TRANSACTION_TYPE,
            REASON,
            TRANSACTION_MEMO,
            CREATED_AT,
            CREATED_BY,
            STORE_ID,
            RECEIPT_ID,
            STORE_CLOSING_ID
        )
        VALUES (
            SEQ_INV_TX.NEXTVAL,
            'RECEIPT',
            '입고 처리',
            '자동 생성',
            SYSDATE - I,
            1,
            MOD(I-1,3)+1,
            I,
            NULL
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- INVENTORY_TRANSACTION_ITEMS 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO INVENTORY_TRANSACTION_ITEMS (
            INVENTORY_TRANSACTION_ITEM_ID,
            BEFORE_QUANTITY,
            AFTER_QUANTITY,
            INVENTORY_TRANSACTION_ID,
            STORE_INVENTORY_ID
        )
        VALUES (
            SEQ_INV_TX_ITEM.NEXTVAL,
            100,
            150,
            I,
            I
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- NOTICES 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO NOTICES (
            NOTICE_ID,
            TITLE,
            CONTENT,
            CREATED_AT,
            DELETED_AT
        )
        VALUES (
            SEQ_NOTICE.NEXTVAL,
            '공지사항 ' || I,
            '공지사항 내용 ' || I,
            SYSDATE - I,
            NULL
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- NOTICE_FILES 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO NOTICE_FILES (
            NOTICE_FILE_ID,
            ORIGINAL_NAME,
            STORED_NAME,
            STORAGE_PATH,
            CREATED_AT,
            DELETED_AT,
            NOTICE_ID
        )
        VALUES (
            SEQ_NOTICE_FILE.NEXTVAL,
            'notice_' || I || '.pdf',
            LOWER(RAWTOHEX(SYS_GUID())) || '.pdf',
            '/upload/notice',
            SYSDATE,
            NULL,
            I
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- INQUIRIES 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO INQUIRIES (
            INQUIRY_ID,
            TITLE,
            CONTENT,
            ANSWER_CONTENT,
            CREATED_AT,
            ANSWERED_AT,
            DELETED_AT,
            STORE_ID
        )
        VALUES (
            SEQ_INQ.NEXTVAL,
            '문의사항 ' || I,
            '문의 내용 ' || I,
            '답변 내용 ' || I,
            SYSDATE - I,
            SYSDATE - I + 1,
            NULL,
            MOD(I-1,3)+1
        );

    END LOOP;

END;
/

--------------------------------------------------------
-- INQUIRY_FILES 20건
--------------------------------------------------------
BEGIN

    FOR I IN 1..20 LOOP

        INSERT INTO INQUIRY_FILES (
            INQUIRY_FILE_ID,
            ORIGINAL_NAME,
            STORED_NAME,
            STORAGE_PATH,
            ATTACH_TARGET,
            CREATED_AT,
            DELETED_AT,
            INQUIRY_ID
        )
        VALUES (
            SEQ_INQ_FILE.NEXTVAL,
            'inquiry_' || I || '.jpg',
            LOWER(RAWTOHEX(SYS_GUID())) || '.jpg',
            '/upload/inquiry',
            CASE
                WHEN MOD(I,2)=0 THEN 'A'
                ELSE 'Q'
            END,
            SYSDATE,
            NULL,
            I
        );

    END LOOP;

END;
/


-- COMMIT

COMMIT;

-- 최종 점검
SELECT COUNT(*) FROM MATERIALS;
SELECT COUNT(*) FROM MATERIAL_FILES;
SELECT COUNT(*) FROM STORE_INVENTORIES;

SELECT COUNT(*) FROM PURCHASE_ORDERS;
SELECT COUNT(*) FROM PURCHASE_ORDER_ITEMS;
SELECT COUNT(*) FROM PURCHASE_ORDER_HISTORIES;

SELECT COUNT(*) FROM RECEIPTS;
SELECT COUNT(*) FROM RECEIPT_ITEMS;

SELECT COUNT(*) FROM STORE_CLOSINGS;
SELECT COUNT(*) FROM STORE_CLOSING_ITEMS;

SELECT COUNT(*) FROM INVENTORY_TRANSACTIONS;
SELECT COUNT(*) FROM INVENTORY_TRANSACTION_ITEMS;

SELECT COUNT(*) FROM NOTICES;
SELECT COUNT(*) FROM NOTICE_FILES;

SELECT COUNT(*) FROM INQUIRIES;
SELECT COUNT(*) FROM INQUIRY_FILES;
