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
</head>
<body>
	<t:menubarBO>
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
                        매장명 : ${sessionScope.loginUser.storeId}
                    </td>
                    <td>
                        매장 담당자 : ${sessionScope.loginUser.loginId}
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
                    <tr>
                        <td>${p.purchaseRequestId}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.status eq 'REQUESTED'}">
                                    요청중
                                </c:when>
                                <c:when test="${p.status eq 'APPROVED'}">
                                    승인
                                </c:when>
                                <c:otherwise>
                                    반려
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${p.itemSummary}</td>
                        <td>${p.totalAmount}</td>
                        <td>${p.createdAt}</td>
                    </tr>
                </c:forEach>

                <tr>
                    <td>1111</td>
                    <td>배송중</td>
                    <td>토마토 외 5건</td>
                    <td>150,000</td>
                    <td>2026.02.25</td>
                </tr>
                
                <tr>
                    <td>1112</td>
                    <td>요청중</td>
                    <td>토마토 외 5건</td>
                    <td>150,000</td>
                    <td>2026.02.25</td>
                </tr>      
            </tbody>
        </table>
        <br>
        <t:pagination pageInfo="${pageInfo}"></t:pagination>
	</t:menubarBO>
	

</body>
</html>