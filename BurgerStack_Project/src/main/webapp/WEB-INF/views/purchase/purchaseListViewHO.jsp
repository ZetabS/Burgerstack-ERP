<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 목록 조회</title>
<jsp:include page="../common/header.jsp" />
<style>
    table.table2 tbody tr:hover {
        background-color: #f5f5f5;
    }
</style>
</head>
<body>
	<t:menubarHO>
        <h2>발주 목록</h2>

        <!-- 검색 -->
        <div class="search-area" align="right">
            <select name="status" id="purchaseStatus">
                <option>전체</option>
                <option>검수중</option>
                <option>배송중</option>
            </select>
            <input type="date">
            ~
            <input type="date">
            <input type="text" placeholder="검색어 입력">
            <button type="button" onclick="alert('클릭!')">
                <img src="..\..\resources\images\BS_logo2.png" style="width: 16px;"/>
                검색
            </button>                
        </div>
	
        <div class="receive-info">
            <table>
                <tr>
                    <td>
                        <!-- <b>매장명 :</b> ${sessionScope.loginUser.storeName} -->
                    </td>
                    <td>
                        <!-- <b>매장 담당자 :</b> ${sessionScope.loginUser.userName} -->
                    </td>
                </tr>
            </table>
            
        </div>
        <table class="table2">
            <thead>
                <tr>
                    <th>발주번호</th>
                    <th>상태</th>
                    <th>품목요약</th>
                    <th>총액</th>
                    <th>요청일</th>
                </tr>
            </thead>
            
            <tbody> 
                <c:forEach var="p" items="${list}">
                    <tr style="cursor:pointer;"
                        onclick="location.href='${pageContext.request.contextPath}/admin/purchases/${p.purchaseOrderId}'">
                        <td>${p.purchaseOrderId}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.status eq 'REQUESTED'}">
                                    요청중
                                </c:when>
                                <c:when test="${p.status eq 'APPROVED'}">
                                    승인
                                </c:when>
                                <c:when test="${p.status eq 'CANCELED'}">
                                    발주취소
                                </c:when>
                                <c:when test="${p.status eq 'REJECTED'}">
                                    발주취소
                                </c:when>
                                <c:when test="${p.status eq 'PARTIALLY_APPROVED'}">
                                    부분승인
                                </c:when>
                                <c:otherwise>
                                    배송중
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${p.itemSummary}</td>
                        <td>${p.totalAmount}</td>
                        <td>${p.createdAt}</td>
                    </tr>
                </c:forEach>      
            </tbody>
        </table>
        <br>
        <t:pagination pageInfo="${pageInfo}"></t:pagination>
	</t:menubarHO>
	

</body>
</html>