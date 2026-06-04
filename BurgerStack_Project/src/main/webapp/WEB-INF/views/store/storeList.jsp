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
   .store-list-wrap {
        width: 1300px;
        margin: 0 auto;
        padding-top: 35px;
    }

    .page-title {
        margin-bottom: 8px;
        font-size: 32px;
        font-weight: bold;
    }

    .page-desc {
        margin-bottom: 30px;
        color: #6b7280;
        font-size: 14px;
    }

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

    .search-area select,
    .search-area input[type="date"] {
        height: 36px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 0 10px;
    }

    .search-box {
        display: flex;
        height: 36px;
    }

    .search-box input {
        width: 150px;
        border: 1px solid #d1d5db;
        border-right: none;
        border-radius: 8px 0 0 8px;
        padding-left: 10px;
    }

    .search-btn {
        width: 40px;
        border: none;
        border-radius: 0 8px 8px 0;
        background: #374151;
        cursor: pointer;
    }

    .search-btn img {
        width: 24px;
        height: 24px;
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
        cursor: pointer;
    }

    tbody tr:hover {
        background: #f2f6ff;
    }

    .status-open {
        color: #16a34a;
        font-weight: bold;
    }

    .status-closed {
        color: #ef4444;
        font-weight: bold;
    }

    
   
</style>
</head>

<body>

<t:menubarHO>

    <section class="list-card">

    <h2 class="section-title">점포 목록</h2>

    <form action="${pageContext.request.contextPath}/admin/stores"
          method="get">

        <div class="search-area">

            <select name="status" onchange="this.form.submit()">
                <option value="">전체상태</option>
                <option value="OPEN"
                    ${param.status eq 'OPEN' ? 'selected' : ''}>
                    영업중
                </option>
                <option value="CLOSED"
                    ${param.status eq 'CLOSED' ? 'selected' : ''}>
                    폐점
                </option>
            </select>

            <input type="date"
                   name="startDate"
                   value="${param.startDate}">

            <input type="date"
                   name="endDate"
                   value="${param.endDate}">

            <div class="search-box">

                <input type="text"
                       name="keyword"
                       placeholder="검색어 입력"
                       value="${param.keyword}">

                <button type="submit"
                        class="search-btn">

                    <img src="${pageContext.request.contextPath}/resources/images/search.png">

                </button>

            </div>

        </div>

    </form>

    <table>

        <thead>
            <tr>
                <th>점포ID</th>
                <th>점포명</th>
                <th>주소</th>
                <th>연락처</th>
                <th>상태</th>
                <th>등록일</th>
            </tr>
        </thead>

        <tbody>

            <c:forEach var="s" items="${list}">

                <tr onclick="location.href='${pageContext.request.contextPath}/admin/stores/${s.storeId}'">

                    <td>${s.storeId}</td>
                    <td>${s.storeName}</td>
                    <td>${s.address}</td>
                    <td>${s.phone}</td>

                    <td>

                        <c:choose>

                            <c:when test="${s.status eq 'OPEN'}">
                                <span class="status-open">영업중</span>
                            </c:when>

                            <c:otherwise>
                                <span class="status-closed">폐점</span>
                            </c:otherwise>

                        </c:choose>

                    </td>

                    <td>${s.createdAt}</td>

                </tr>

            </c:forEach>

        </tbody>

    </table>

</section>
        
        <br>

        <!-- 페이지네이션 -->
        <t:pagination pageInfo="${pageInfo}" />

    </div>

</t:menubarHO>

</body>
</html>