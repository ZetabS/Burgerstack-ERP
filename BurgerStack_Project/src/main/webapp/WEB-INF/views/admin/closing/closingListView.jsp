<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 마감 목록</title>

<style>
    .list-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 35px 40px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .section-title {
        margin-bottom: 25px;
        padding-left: 12px;
        border-left: 5px solid #19c765;
        font-size: 22px;
        font-weight: bold;
    }

    .search-area {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 8px;
        margin-bottom: 18px;
    }

    .search-area input {
        height: 36px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 0 10px;
    }

    .search-btn {
        height: 36px;
        padding: 0 16px;
        border: none;
        border-radius: 8px;
        background: #374151;
        color: white;
        cursor: pointer;
    }

    .reset-link {
        height: 36px;
        line-height: 36px;
        padding: 0 14px;
        border-radius: 8px;
        background: #e5e7eb;
        color: #374151;
        text-decoration: none;
        font-size: 13px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
        font-size: 13px;
    }

    thead tr {
        background: #19c765;
        color: white;
        height: 42px;
    }

    th, td {
        padding: 12px 10px;
    }

    tbody tr {
        border-bottom: 1px solid #e5e7eb;
    }

    tbody tr:hover {
        background: #f2f6ff;
    }

    .detail-link {
        color: #2563eb;
        font-weight: bold;
        text-decoration: none;
    }
</style>
</head>

<body>

<t:menubarHO>

<section class="list-card">

    <h2 class="section-title">관리자 마감 목록</h2>

    <form action="${pageContext.request.contextPath}/admin/closings"
          method="get">

        <div class="search-area">
            <span>점포ID</span>

            <input type="number"
                   name="storeId"
                   value="${storeId}"
                   placeholder="점포ID 입력">

            <button type="submit" class="search-btn">
                조회
            </button>

            <a class="reset-link"
               href="${pageContext.request.contextPath}/admin/closings">
                전체
            </a>
        </div>

    </form>

    <table>
        <thead>
            <tr>
                <th>마감번호</th>
                <th>점포ID</th>
                <th>영업일</th>
                <th>마감메모</th>
                <th>마감일시</th>
                <th>상세</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="c" items="${list}">
                <tr>
                    <td>${c.storeClosingId}</td>
                    <td>${c.storeId}</td>
                    <td>${c.businessDate}</td>
                    <td>${c.closingMemo}</td>
                    <td>${c.closedAt}</td>
                    <td>
                        <a class="detail-link"
                           href="${pageContext.request.contextPath}/admin/closings/${c.storeClosingId}">
                            상세보기
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</section>

</t:menubarHO>

</body>
</html>