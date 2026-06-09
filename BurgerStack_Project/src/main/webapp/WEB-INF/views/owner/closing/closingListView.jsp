<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점주 마감 목록</title>

<style>
    .list-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 35px 40px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .section-title {
        margin-bottom: 25px;
        padding-left: 12px;
        border-left: 5px solid #19c765;
        font-size: 22px;
        font-weight: bold;
    }

    .top-area {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 18px;
    }

    .enroll-btn {
        padding: 10px 16px;
        background: #19c765;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-size: 13px;
        font-weight: bold;
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

<t:menubarBO>

<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>

<section class="list-card">

    <h2 class="section-title">점주 마감 목록</h2>

    <div class="top-area">
        <a class="enroll-btn"
           href="${pageContext.request.contextPath}/owner/closings/new">
            일일 재고 마감
        </a>
    </div>

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
                           href="${pageContext.request.contextPath}/owner/closings/${c.storeClosingId}">
                            상세보기
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</section>

</t:menubarBO>

</body>
</html>