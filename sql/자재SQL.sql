-- 자재 사진 등록 쿼리문
-- 파일 JAVA 완성 후 삽입
INSERT INTO FILES(FILE_ID
                , ORIGINAL_NAME
                , STORED_NAME
                , STORAGE_PATH
                , MIME_TYPE
                , FILE_SIZE
                , CREATED_BY
                , CREATED_AT)
           VALUES(SEQ_FILE.NEXTVAL
                , ?
                , ?
                , ?
                , ?
                , ?
                , ?
                , ?);

-- 자재 등록 쿼리문
INSERT INTO MATERIALS(MATERIAL_ID
                    , MATERIAL_CODE
                    , MATERIAL_NAME
                    , MATERIAL_TYPE
                    , COST_PRICE
                    , SELLING_PRICE
                    , IMAGE_FILE_ID
                    , DETAILS
                    , CREATED_BY)
               VALUES(SEQ_MATERIAL.NEXTVAL
                    , ? || '-' || LPAD(SEQ_MATERIAL.CURRVAL, 3, '0')
                    , ?
                    , ?
                    , ?
                    , ?
                    , ?
                    , ?
                    , ?);


-- 자재 전체 목록 조회 쿼리문
-- materialId, materialType, materialName, 파일경로, 파일명, 파일확장자 필요 (jsp에 이미지 출력)
SELECT MATERIAL_ID
     , MATERIAL_TYPE
     , MATERIAL_NAME
     , IMAGE_FILE_ID
     , STORAGE_PATH
     , STORED_NAME
     , MIME_TYPE
  FROM MATERIALS M
  LEFT OUTER JOIN FILES F ON (M.IMAGE_FILE_ID = F.FILE_ID)
WHERE M.STATUS != 'INACTIVE'
ORDER BY M.MATERIAL_TYPE, M.MATERIAL_NAME;

-- 자재 상세 목록 조회용 쿼리문
SELECT MATERIAL_NAME
     , COST_PRICE
     , SELLING_PRICE
     , DETAILS
     , M.STATUS
     , CURRENT_QUANTITY
     , IMAGE_FILE_ID
  FROM MATERIALS M
  LEFT JOIN STORE_INVENTORIES USING (MATERIAL_ID)
 WHERE MATERIAL_ID = ?
   AND M.STATUS != 'INACTIVE';

-- 자재 내용 불러울 쿼리문
SELECT M.MATERIAL_ID
     , M.MATERIAL_CODE
     , M.MATERIAL_NAME
     , M.MATERIAL_TYPE
     , M.COST_PRICE
     , M.SELLING_PRICE
     , M.IMAGE_FILE_ID
     , M.DETAILS
     , M.STATUS
     , M.CREATED_BY
     , M.CREATED_AT
     , F.STORAGE_PATH
     , F.STORED_NAME
     , F.ORIGINAL_NAME
    FROM MATERIALS M
    LEFT OUTER JOIN FILES F ON M.IMAGE_FILE_ID = F.FILE_ID
    WHERE M.MATERIAL_ID = ?
      AND M.STATUS != 'INACTIVE';
-- 자재 내용 수정용 쿼리문
UPDATE MATERIALS
   SET MATERIAL_CODE = ? || SUBSTR(MATERIAL_CODE, 3)
     , MATERIAL_NAME = ?
     , MATERIAL_TYPE = ?
     , COST_PRICE    = ?
     , SELLING_PRICE = ?
     , IMAGE_FILE_ID = ?
     , DETAILS       = ?
     , UPDATED_BY    = ?
     , UPDATED_AT    = SYSDATE
 WHERE MATERIAL_ID   = ?
   AND STATUS       != 'INACTIVE';
   
-- 자재 삭제용 쿼리문
UPDATE MATERIALS
   SET STATUS = 'INACTIVE'
 WHERE MATERIAL_ID   = ?
   AND STATUS       != 'INACTIVE';