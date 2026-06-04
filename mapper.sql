<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="storeMapper">

    <!-- 점주 존재 여부 확인 -->
    <select id="checkOwner"
            parameterType="string"
            resultType="int">
        SELECT COUNT(*)
        FROM MANAGER
        WHERE MANAGER_ID = #{ownerId}
    </select>

    <!-- 점포 등록 -->
    <insert id="insertStore"
            parameterType="com.kh.burgerstack.store.model.vo.Store">

        <selectKey keyProperty="storeCode"
                   resultType="int"
                   order="BEFORE">
            SELECT SEQ_STORE_NO.NEXTVAL
            FROM DUAL
        </selectKey>

        INSERT INTO STORE
        (
            STORE_CODE,
            STORE_NAME,
            MANAGER_ID,
            STORE_PHONE,
            STORE_ADDRESS,
            STORE_DETAIL_ADDRESS,
            STORE_STATUS,
            OPEN_DATE
        )
        VALUES
        (
            #{storeCode},
            #{storeName},
            #{ownerId},
            #{storePhone},
            #{storeAddress},
            #{storeDetailAddress},
            '영업중',
            SYSDATE
        )
    </insert>

    <!-- 전체 자재 기준 점포 재고 생성 -->
    <insert id="insertStoreStockMaterial"
            parameterType="int">
        INSERT INTO STORE_STOCK
        (
            STORE_CODE,
            MATERIAL_NO,
            STOCK_QTY
        )
        SELECT
            #{storeCode},
            MATERIAL_NO,
            0
        FROM MATERIAL
    </insert>

    <!-- 관리자 점포 목록 조회 -->
    <select id="selectStoreList"
            parameterType="map"
            resultType="com.kh.burgerstack.store.model.vo.SelectStoreList">
        SELECT
            STORE_CODE AS storeCode,
            STORE_NAME AS storeName,
            STORE_ADDRESS AS storeAddress,
            STORE_PHONE AS storePhone,
            STORE_STATUS AS storeStatus,
            TO_CHAR(OPEN_DATE, 'YYYY.MM.DD') AS openDate
        FROM STORE
        WHERE 1 = 1

        <if test="status != null and status != ''">
            AND STORE_STATUS = #{status}
        </if>

        <if test="startDate != null and startDate != ''">
            AND OPEN_DATE <![CDATA[ >= ]]> TO_DATE(#{startDate}, 'YYYY-MM-DD')
        </if>

        <if test="endDate != null and endDate != ''">
            AND OPEN_DATE <![CDATA[ <= ]]> TO_DATE(#{endDate}, 'YYYY-MM-DD')
        </if>

        <if test="keyword != null and keyword != ''">
            AND (
                STORE_NAME LIKE '%' || #{keyword} || '%'
                OR STORE_ADDRESS LIKE '%' || #{keyword} || '%'
                OR STORE_PHONE LIKE '%' || #{keyword} || '%'
            )
        </if>

        ORDER BY STORE_CODE DESC
    </select>

    <!-- 점포 개수 조회 -->
    <select id="selectStoreCount"
            parameterType="map"
            resultType="int">
        SELECT COUNT(*)
        FROM STORE
        WHERE 1 = 1

        <if test="status != null and status != ''">
            AND STORE_STATUS = #{status}
        </if>

        <if test="startDate != null and startDate != ''">
            AND OPEN_DATE <![CDATA[ >= ]]> TO_DATE(#{startDate}, 'YYYY-MM-DD')
        </if>

        <if test="endDate != null and endDate != ''">
            AND OPEN_DATE <![CDATA[ <= ]]> TO_DATE(#{endDate}, 'YYYY-MM-DD')
        </if>

        <if test="keyword != null and keyword != ''">
            AND (
                STORE_NAME LIKE '%' || #{keyword} || '%'
                OR STORE_ADDRESS LIKE '%' || #{keyword} || '%'
                OR STORE_PHONE LIKE '%' || #{keyword} || '%'
            )
        </if>
    </select>

    <!-- 점포 상세 조회 -->
    <select id="selectStoreDetail"
            parameterType="int"
            resultType="com.kh.burgerstack.store.model.vo.Store">
        SELECT
            STORE_CODE AS storeCode,
            STORE_NAME AS storeName,
            STORE_STATUS AS storeStatus,
            STORE_PHONE AS storePhone,
            STORE_ADDRESS AS storeAddress,
            STORE_DETAIL_ADDRESS AS storeDetailAddress
        FROM STORE
        WHERE STORE_CODE = #{storeCode}
    </select>

    <!-- 점포 점장 조회 -->
    <select id="selectStoreManager"
            parameterType="int"
            resultType="com.kh.burgerstack.store.model.vo.Manager">
        SELECT
            M.MANAGER_ID AS managerId,
            M.MANAGER_NAME AS managerName,
            M.MANAGER_PHONE AS managerPhone,
            M.MANAGER_EMAIL AS managerEmail
        FROM MANAGER M
        JOIN STORE S
          ON M.MANAGER_ID = S.MANAGER_ID
        WHERE S.STORE_CODE = #{storeCode}
    </select>

    <!-- 점포 수정 -->
    <update id="updateStore"
            parameterType="com.kh.burgerstack.store.model.vo.Store">
        UPDATE STORE
        SET
            STORE_NAME = #{storeName},
            STORE_STATUS = #{storeStatus},
            STORE_PHONE = #{storePhone},
            STORE_ADDRESS = #{storeAddress},
            STORE_DETAIL_ADDRESS = #{storeDetailAddress}
        WHERE STORE_CODE = #{storeCode}
    </update>

    <!-- 점포 삭제/폐점 처리 -->
    <update id="deleteStore"
            parameterType="int">
        UPDATE STORE
        SET STORE_STATUS = '폐점'
        WHERE STORE_CODE = #{storeCode}
    </update>

</mapper>