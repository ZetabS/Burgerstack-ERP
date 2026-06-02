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


-- 자재 목록 조회 쿼리문
SELECT MATERIAL_NAME
	 , MATERIAL_TYPE
	 , COST_PRICE
	 , SELLING_PRICE
	 , IMAGE_FILE_ID
	 , DETAILS
	 , CREATED_BY
     , STATUS
  FROM MATERIALS M
  JOIN FILES ON (IMAGE_FILE_ID = FILE_ID)
 WHERE STATUS != 'INACTIVE'
