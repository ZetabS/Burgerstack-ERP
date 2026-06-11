<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 목록 조회</title>
<style>
    table.table2 tbody tr:hover {
        background-color: #f5f5f5;
    }
    .content-top{
        display: flex;
    }
    .top-info {
        text-align: left;
        width: 200px;
    }
</style>
</head>
<body>
	<t:layout>
        <h2>발주 목록</h2>

        <div class="content-top">
        
            <div class="top-info">
                <button class="button-primary" onclick="location.href='/burgerstack/owner/purchases/new'">발주 요청</button>
            </div>
            <!-- 검색 -->
            <div class="search-area" align="right">
                <form method="get" id="searchForm">
                    <select name="status" onchange="autoSearch()">

                        <option value="">전체상태</option>

                        <option value="REQUESTED"
                            ${condition.status eq 'REQUESTED' ? 'selected' : ''}>
                            요청중
                        </option>

                        <option value="PARTIALLY_APPROVED"
                            ${condition.status eq 'PARTIALLY_APPROVED' ? 'selected' : ''}>
                            부분 승인
                        </option>

                        <option value="APPROVED"
                            ${condition.status eq 'APPROVED' ? 'selected' : ''}>
                            승인
                        </option>

                        <option value="REJECTED"
                            ${condition.status eq 'REJECTED' ? 'selected' : ''}>
                            반려
                        </option>

                        <option value="CANCELED"
                            ${condition.status eq 'CANCELED' ? 'selected' : ''}>
                            취소
                        </option>

                        <option value="RECEIVED"
                            ${condition.status eq 'RECEIVED' ? 'selected' : ''}>
                            배송중
                        </option>
                    </select>
                    <input type="date"
                            name="startDate"
                            value="${condition.startDate}"
                            onchange="autoSearch()">

                    ~

                    <input type="date"
                            name="endDate"
                            value="${condition.endDate}"
                            onchange="autoSearch()">
                    <input type="text"
                            name="keyword"
                            value="${condition.keyword}"
                            placeholder="품목명 입력">
                    <button type="submit">
                        <img src="..\..\resources\images\BS_logo2.png" style="width: 16px;"/>
                        검색
                    </button>
                </form>             
            </div>
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
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="5" style="text-align:center;">
                            조회된 정보가 없습니다.
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="p" items="${list}">
                    <tr style="cursor:pointer;"
                        onclick="location.href='${pageContext.request.contextPath}/owner/purchases/${p.purchaseOrderId}'">
                        <td>${p.purchaseOrderId}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.status eq 'REQUESTED'}">
                                    요청중
                                </c:when>
                                <c:when test="${p.status eq 'PARTIALLY_APPROVED'}">
                                    부분승인
                                </c:when>
                                <c:when test="${p.status eq 'APPROVED'}">
                                    승인
                                </c:when>
                                <c:when test="${p.status eq 'CANCELED'}">
                                    발주취소
                                </c:when>
                                <c:when test="${p.status eq 'REJECTED'}">
                                    반려
                                </c:when>
                                <c:when test="${p.status eq 'RECEIVED'}">
                                    입고완료
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
	</t:layout>
	
    <script>
        function autoSearch() {
            document.getElementById("searchForm").submit();
        }
    </script>
</body>
</html>