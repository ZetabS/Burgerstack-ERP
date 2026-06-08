<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common/header.jsp" />
</head>
<body>
    <t:menubarBO>
        <h2>입고 이력</h2>

        <!-- 검색 -->
        <div class="search-area" align="right">
            <select name="dateType" id="dateType">
                <option value="">전체</option>
                <option value="requestDate">요청일</option>
                <option value="receivedAt">입고 완료일</option>
            </select>

            <input type="date" name="startDate">
            ~
            <input type="date" name="endDate">

            <input type="text" name="keyword" placeholder="검색어 입력">

            <button type="button" onclick="alert('검색 기능은 나중에 연결')">
                <img src="${pageContext.request.contextPath}/resources/images/BS_logo2.png"
                     style="width: 16px;"/>
                검색
            </button>
        </div>

        <table class="table">
            <thead>
                <tr>
                    <th>입고번호</th>
                    <th>발주번호</th>
                    <th>입고 메모</th>
                    <th>입고 완료일</th>
                    <th>상세</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="r" items="${list}">
                    <tr>
                        <td>${r.receiptId}</td>
                        <td>${r.purchaseOrderId}</td>
                        <td>${r.receiptMemo}</td>
                        <td>${r.receivedAt}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/owner/receipts/${r.receiptId}">
                                상세보기
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty list}">
                    <tr>
                        <td colspan="5">입고 이력이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <ui:pagination pageInfo="${pageInfo}"></ui:pagination>

    </t:menubarBO>
</body>
</html>