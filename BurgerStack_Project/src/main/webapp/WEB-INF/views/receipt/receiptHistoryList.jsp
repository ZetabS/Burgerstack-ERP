<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
.page-title {
    font-size: 30px;
    font-weight: 700;
    margin-bottom: 28px;
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
    padding: 0 12px;
    font-size: 14px;
}

.search-area button,
.search-area a {
    height: 36px;
    border: none;
    border-radius: 8px;
    padding: 0 14px;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
}

.search-area button {
    background: #ff6b00;
    color: white;
}

.search-area button:hover {
    background: #e45f00;
}

.search-area a {
    background: #fff;
    color: #374151;
    border: 1px solid #d1d5db;
}

.table-guide {
    font-size: 13px;
    color: #888;
    margin-bottom: 15px;
}

.table {
    width: 100%;
    border-collapse: collapse;
    font-size: 15px;
    background: #fff;
}

.table thead th {
    background: #f8fafc;
    color: #374151;
    font-weight: 700;
    border-top: 1px solid #e5e7eb;
    border-bottom: 2px solid #d1d5db;
    padding: 14px 12px;
    text-align: center;
}

.table tbody td {
    border-bottom: 1px solid #e5e7eb;
    padding: 14px 12px;
    vertical-align: middle;
    text-align: center;
}

.table tbody tr:hover {
    background: #fff7ed;
}

.clickable-row {
    cursor: pointer;
}

.text-left {
    text-align: left !important;
}

.status-badge {
    display: inline-block;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 600;
}

.status-normal {
    background: #dcfce7;
    color: #166534;
}

.status-diff {
    background: #ffedd5;
    color: #c2410c;
}

.empty-row {
    text-align: center;
    color: #888;
    padding: 28px 12px !important;
}
</style>
</head>

<body>

<t:layout>

    <h2 class="page-title">입고 이력</h2>

    <p class="table-guide">
        행을 클릭하면 상세 정보를 확인할 수 있습니다.
    </p>

    <!-- 기간 필터 -->
    <form class="search-area"
          method="get"
          action="${pageContext.request.contextPath}/owner/receipts">

        <input type="date"
               name="startDate"
               value="${param.startDate}">

        <span>~</span>

        <input type="date"
               name="endDate"
               value="${param.endDate}">

        <button type="submit">
            조회
        </button>

        <a href="${pageContext.request.contextPath}/owner/receipts">
            초기화
        </a>
    </form>

    <table class="table">
        <thead>
            <tr>
                <th style="width: 18%;">입고 코드</th>
                <th style="width: 42%;">품목요약</th>
                <th style="width: 18%;">상태</th>
                <th style="width: 22%;">입고 완료일시</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="r" items="${list}">
                <tr class="clickable-row"
                    onclick="location.href='${pageContext.request.contextPath}/owner/receipts/${r.receiptId}'">

                    <td>
                        <c:choose>
                            <c:when test="${not empty r.receiptCode}">
                                ${r.receiptCode}
                            </c:when>
                            <c:otherwise>
                                R${r.receiptId}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td class="text-left">
                        <c:choose>
                            <c:when test="${not empty r.materialSummary}">
                                ${r.materialSummary}
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${r.receiptStatus eq 'DIFFERENCE'}">
                                <span class="status-badge status-diff">
                                    차이 있음
                                </span>
                            </c:when>

                            <c:when test="${r.receiptStatus eq 'NORMAL'}">
                                <span class="status-badge status-normal">
                                    정상 입고
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="status-badge status-normal">
                                    ${r.receiptStatus}
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${not empty r.receivedAt}">
                                ${r.receivedAt.toString().replace('T',' ').substring(0,19)}
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty list}">
                <tr>
                    <td colspan="4" class="empty-row">
                        입고 이력이 없습니다.
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <ui:pagination pageInfo="${pageInfo}"></ui:pagination>

</t:layout>

</body>
</html>