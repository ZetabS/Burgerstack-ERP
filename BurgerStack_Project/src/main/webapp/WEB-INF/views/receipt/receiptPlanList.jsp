<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>

<body>
<t:layout>

    <h2>입고 예정 목록</h2>

    <!-- 검색 -->
    <div class="search-area" align="right">
        <select name="status" id="purchaseStatus">
		    <option value="">전체</option>
		    <option value="APPROVED">승인</option>
		    <option value="PARTIALLY_APPROVED">부분 승인</option>
		</select>

        <input type="date">
        ~
        <input type="date">

        <input type="text" placeholder="검색어 입력">

        <button type="button" onclick="alert('클릭!')">
            <img src="${pageContext.request.contextPath}/resources/images/BS_logo2.png"
                 style="width: 16px;"/>
            검색
        </button>
    </div>

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
                                <a href="${pageContext.request.contextPath}/owner/purchases/${p.purchaseOrderId}/receipt">
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