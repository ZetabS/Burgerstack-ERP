-- 전체 목록 조회 쿼리문
-- materialId, materialType, materialName, 파일경로, 파일명, 파일확장자 필요 (jsp에 이미지 출력)
SELECT M.MATERIAL_ID
     , M.MATERIAL_CODE
     , M.MATERIAL_NAME
     , M.MATERIAL_TYPE
     , M.SUPPLY_PRICE
     , M.STATUS
     , MF.MATERIAL_FILE_ID
     , MF.STORED_NAME
     , MF.STORAGE_PATH
     , MF.ORIGINAL_NAME
     , MF.CREATED_AT  AS FILE_CREATED_AT
     , MF.DELETED_AT
     , MF.MATERIAL_ID AS MF_MATERIAL_ID
  FROM MATERIALS M
  LEFT OUTER JOIN (
      SELECT MATERIAL_FILE_ID
           , MATERIAL_ID
           , STORED_NAME
           , STORAGE_PATH
           , ORIGINAL_NAME
           , CREATED_AT
           , DELETED_AT
        FROM MATERIAL_FILES
       WHERE DELETED_AT IS NULL
         AND MATERIAL_FILE_ID IN (
             SELECT MIN(MATERIAL_FILE_ID)
               FROM MATERIAL_FILES
              WHERE DELETED_AT IS NULL
              GROUP BY MATERIAL_ID
         )
  ) MF ON M.MATERIAL_ID = MF.MATERIAL_ID
 WHERE M.STATUS != 'INACTIVE'
 ORDER BY CASE MATERIAL_TYPE
             WHEN 'AF' THEN 1  -- 상온식품
             WHEN 'RF' THEN 2  -- 냉장식품
             WHEN 'FF' THEN 3  -- 냉동식품
             WHEN 'PK' THEN 4  -- 포장재
             WHEN 'KW' THEN 5  -- 주방용품
             ELSE 6            -- 기타(ET)
         END ASC;

-- 상세 조회 (첨부파일 전체) 쿼리문
SELECT M.MATERIAL_ID
     , M.MATERIAL_CODE
     , M.MATERIAL_NAME
     , M.MATERIAL_TYPE
     , M.SUPPLY_PRICE
     , M.DETAILS
     , M.STATUS
     , M.CREATED_AT
     , M.UPDATED_AT
     , MF.MATERIAL_FILE_ID
     , MF.STORED_NAME
     , MF.STORAGE_PATH
     , MF.ORIGINAL_NAME
     , MF.CREATED_AT  AS FILE_CREATED_AT
     , MF.DELETED_AT
     , MF.MATERIAL_ID AS MF_MATERIAL_ID
  FROM MATERIALS M
  LEFT OUTER JOIN MATERIAL_FILES MF
    ON M.MATERIAL_ID = MF.MATERIAL_ID
   AND MF.DELETED_AT IS NULL
 WHERE M.MATERIAL_ID = #{materialId}
   AND M.STATUS != 'INACTIVE';

-- 