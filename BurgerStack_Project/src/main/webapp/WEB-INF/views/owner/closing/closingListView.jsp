<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점주 마감 이력</title>

<style>
    .list-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 35px 40px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
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

    .top-area {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 18px;
        gap: 12px;
    }

    .filter-area {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .filter-area input {
        height: 36px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 0 10px;
        font-size: 13px;
    }

    .filter-area button,
    .filter-area a,
    .enroll-btn {
        height: 36px;
        padding: 0 14px;
        border-radius: 8px;
        font-size: 13px;
        font-weight: bold;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    .filter-area button {
        border: none;
        background: #19c765;
        color: white;
    }

    .filter-area a {
        border: 1px solid #d1d5db;
        background: #fff;
        color: #374151;
    }

    .enroll-btn {
        background: #19c765;
        color: white;
    }

    .enroll-btn:hover,
    .filter-area button:hover {
        background: #16a34a;
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

    tbody tr.clickable-row {
        cursor: pointer;
    }

    tbody tr.clickable-row:hover {
        background: #f2f6ff;
    }

    .text-left {
        text-align: left;
    }

    .empty-row {
        color: #888;
        padding: 28px 10px;
    }
</style>
</head>

<body>

<t:layout>

<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>

<section class="list-card">

    <h2 class="section-title">마감 이력</h2>

    <p class="table-guide">
        행을 클릭하면 상세 정보를 확인할 수 있습니다.
    </p>

    <div class="top-area">

        <form class="filter-area"
              action="${pageContext.request.contextPath}/owner/closings"
              method="get">

            <input type="date"
                   name="startDate"
                   value="${param.startDate}">

            <span>~</span>

            <input type="date"
                   name="endDate"
                   value="${param.endDate}">

            <button type="submit">조회</button>

            <a href="${pageContext.request.contextPath}/owner/closings">
                초기화
            </a>

        </form>

        <a class="enroll-btn"
           href="${pageContext.request.contextPath}/owner/closings/new">
            일일 재고 마감
        </a>

    </div>

    <table>
        <thead>
            <tr>
                <th style="width: 25%;">마감코드</th>
                <th style="width: 25%;">영업일</th>
                <th style="width: 50%;">비고</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="c" items="${list}">
                <tr class="clickable-row"
                    onclick="location.href='${pageContext.request.contextPath}/owner/closings/${c.storeClosingId}'">

                    <td>
                        <c:choose>
                            <c:when test="${not empty c.closingCode}">
                                ${c.closingCode}
                            </c:when>
                            <c:otherwise>
                                C${c.storeClosingId}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>${c.businessDate}</td>

                    <td class="text-left">
                        <c:choose>
                            <c:when test="${empty c.closingMemo}">
                                -
                            </c:when>
                            <c:otherwise>
                                ${c.closingMemo}
                            </c:otherwise>
                        </c:choose>
                    </td>

                </tr>
            </c:forEach>

            <c:if test="${empty list}">
                <tr>
                    <td colspan="3" class="empty-row">
                        마감 이력이 없습니다.
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>

</section>

</t:layout>

</body>
</html>