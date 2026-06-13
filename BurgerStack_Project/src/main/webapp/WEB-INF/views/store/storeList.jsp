<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점포 목록 조회</title>

<style>
    .list-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 35px 40px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        width: 100%;
        box-sizing: border-box;
    }

    .section-title {
        margin-bottom: 10px;
        padding-left: 12px;
        border-left: 5px solid #19c765;
        font-size: 22px;
        font-weight: bold;
    }

    .table-guide {
        font-size: 13px;
        color: #888;
        margin-bottom: 20px;
    }

    .search-form {
        width: 100%;
        margin-bottom: 18px;
    }

    .search-area {
        width: 100%;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 8px;
    }

    .search-area select {
        height: 36px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 0 10px;
        font-size: 13px;
        background: #fff;
    }

    .search-box {
        display: flex;
        height: 36px;
    }

    .search-box input {
        width: 190px;
        border: 1px solid #d1d5db;
        border-right: none;
        border-radius: 8px 0 0 8px;
        padding-left: 10px;
        font-size: 13px;
        box-sizing: border-box;
    }

    .search-btn {
        width: 42px;
        border: none;
        border-radius: 0 8px 8px 0;
        background: #374151;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .search-btn img {
        width: 20px;
        height: 20px;
    }

    .reset-btn {
        height: 36px;
        padding: 0 14px;
        border-radius: 8px;
        border: 1px solid #d1d5db;
        background: #fff;
        color: #374151;
        font-size: 13px;
        font-weight: bold;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        box-sizing: border-box;
    }

    .table-area {
        width: 100%;
        clear: both;
    }

    .store-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
        font-size: 13px;
    }

    .store-table thead tr {
        background: #19c765;
        color: white;
        height: 42px;
    }

    .store-table th,
    .store-table td {
        padding: 12px 10px;
        border-bottom: 1px solid #e5e7eb;
    }

    .store-table tbody tr.clickable-row {
        cursor: pointer;
    }

    .store-table tbody tr.clickable-row:hover {
        background: #f2f6ff;
    }

    .text-left {
        text-align: left;
    }

    .status-badge {
        display: inline-block;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 700;
    }

    .status-open {
        background: #dcfce7;
        color: #166534;
    }

    .status-closed {
        background: #fee2e2;
        color: #b91c1c;
    }

    .empty-row {
        color: #888;
        padding: 28px 10px !important;
    }

    .pagination-area {
        width: 100%;
        margin-top: 22px;
        display: flex;
        justify-content: center;
    }
</style>
</head>

<body>

<t:layout>

<section class="list-card">

    <h2 class="section-title">점포 목록</h2>

    <p class="table-guide">
        행을 클릭하면 점포 상세 정보를 확인할 수 있습니다.
    </p>

    <form class="search-form"
          action="${pageContext.request.contextPath}/admin/stores"
          method="get">

        <div class="search-area">

            <select name="status" onchange="this.form.submit()">
                <option value="" ${empty param.status ? 'selected' : ''}>
                    전체 상태
                </option>

                <option value="OPEN" ${param.status eq 'OPEN' ? 'selected' : ''}>
                    영업중
                </option>

                <option value="CLOSED" ${param.status eq 'CLOSED' ? 'selected' : ''}>
                    폐점
                </option>
            </select>

            <select name="sort" onchange="this.form.submit()">
                <option value="" ${empty param.sort ? 'selected' : ''}>
                    최신순
                </option>

                <option value="code" ${param.sort eq 'code' ? 'selected' : ''}>
                    점포코드순
                </option>

                <option value="name" ${param.sort eq 'name' ? 'selected' : ''}>
                    점포명순
                </option>

                <option value="status" ${param.sort eq 'status' ? 'selected' : ''}>
                    상태순
                </option>
            </select>

            <div class="search-box">

                <input type="text"
                       name="keyword"
                       placeholder="점포명, 코드, 주소 검색"
                       value="${param.keyword}">

                <button type="submit"
                        class="search-btn">

                    <img src="${pageContext.request.contextPath}/resources/images/search.png">

                </button>

            </div>

            <a class="reset-btn"
               href="${pageContext.request.contextPath}/admin/stores">
                초기화
            </a>

        </div>

    </form>

    <div class="table-area">

        <table class="store-table">

            <thead>
                <tr>
                    <th style="width: 20%;">점포 코드</th>
                    <th style="width: 25%;">점포명</th>
                    <th style="width: 40%;">주소</th>
                    <th style="width: 15%;">상태</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="s" items="${list}">
                    <tr class="clickable-row"
                        onclick="location.href='${pageContext.request.contextPath}/admin/stores/${s.storeId}'">

                        <td>
                            <c:choose>
                                <c:when test="${not empty s.storeCode}">
                                    ${s.storeCode}
                                </c:when>
                                <c:otherwise>
                                    S${s.storeId}
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>${s.storeName}</td>

                        <td class="text-left">
                            <c:choose>
                                <c:when test="${empty s.address}">
                                    -
                                </c:when>
                                <c:otherwise>
                                    ${s.address}
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${s.status eq 'OPEN'}">
                                    <span class="status-badge status-open">
                                        영업중
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="status-badge status-closed">
                                        폐점
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                    </tr>
                </c:forEach>

                <c:if test="${empty list}">
                    <tr>
                        <td colspan="4" class="empty-row">
                            조회된 점포가 없습니다.
                        </td>
                    </tr>
                </c:if>

            </tbody>

        </table>

    </div>

    <div class="pagination-area">
        <t:pagination pageInfo="${pageInfo}" />
    </div>

</section>

</t:layout>

</body>
</html>