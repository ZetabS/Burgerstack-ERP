<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<head>
<meta charset="UTF-8">

<style>
    h2 {
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

    .search-area select,
    .search-area input {
        height: 36px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 0 12px;
        font-size: 14px;
        background: #fff;
    }

    .search-area button {
        height: 36px;
        border: none;
        border-radius: 8px;
        padding: 0 14px;
        background: #ff6b00;
        color: white;
        font-weight: 600;
        cursor: pointer;
    }

    .search-area button:hover {
        background: #e45f00;
    }

    .table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
        background: transparent;
    }

    .table thead th {
        padding: 14px 12px;
        border-top: 1px solid #e5e7eb;
        border-bottom: 2px solid #d1d5db;
        color: #111827;
        font-weight: 700;
        text-align: left;
    }

    .table tbody td {
        padding: 16px 12px;
        border-bottom: 1px solid #e5e7eb;
        vertical-align: middle;
    }

    .table tbody tr:hover {
        background: #fff7ed;
    }

    .receipt-check-btn {
        display: inline-block;
        padding: 8px 16px;
        background: #ff6b00;
        color: #fff !important;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none !important;
        border: none;
        cursor: pointer;
        transition: background 0.2s ease, transform 0.1s ease;
    }

    .receipt-check-btn:hover {
        background: #e45f00;
        color: #fff !important;
        text-decoration: none !important;
    }

    .receipt-check-btn:active {
        transform: scale(0.97);
    }
</style>
</head>

<body>
<t:layout>

    <h2>입고 예정 목록</h2>

    <!-- 검색 -->
    <!-- 검색 -->
	<form action="${pageContext.request.contextPath}/owner/receipts/planned"
	      method="get">
	
	    <div class="search-area" align="right">
	
	        <select name="status" id="purchaseStatus">
	            <option value="" ${empty status ? 'selected' : ''}>전체</option>
	            <option value="APPROVED" ${status eq 'APPROVED' ? 'selected' : ''}>승인</option>
	            <option value="PARTIALLY_APPROVED" ${status eq 'PARTIALLY_APPROVED' ? 'selected' : ''}>부분 승인</option>
	        </select>
	
	        <input type="date">
	        ~
	        <input type="date">
	
	        <input type="text" placeholder="검색어 입력">
	
	        <button type="submit">
	            <img src="${pageContext.request.contextPath}/resources/images/BS_logo2.png"
	                 style="width: 16px;"/>
	            검색
	        </button>
	
	    </div>
	
	</form>

    <table class="table">
        <thead>
            <tr>
                <th>발주번호</th>
                <th>상태</th>
                <th>품목요약</th>
                <th>총액</th>
                <th>요청일</th>
                <th>입고확인</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
                <c:when test="${empty list}">
                    <tr>
                        <td colspan="6" align="center">
                            입고 예정 발주가 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="p" items="${list}">
                        <tr>
                            <td>${p.purchaseOrderId}</td>
                            <td>
							    <c:choose>
							        <c:when test="${p.status eq 'APPROVED'}">
							            승인
							        </c:when>
							
							        <c:when test="${p.status eq 'PARTIALLY_APPROVED'}">
							            부분 승인
							        </c:when>
							
							        <c:otherwise>
							            ${p.status}
							        </c:otherwise>
							    </c:choose>
							</td>
                            <td>${p.materialSummary}</td>
                            <td>${p.totalAmount}</td>
                            <td>${p.createdAt}</td>
                            <td>
							    <a class="receipt-check-btn"
							       href="${pageContext.request.contextPath}/owner/purchases/${p.purchaseOrderId}/receipt">
							        입고 확인
							    </a>
							</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <ui:pagination pageInfo="${pageInfo}"></ui:pagination>

</t:layout>
</body>
</html>