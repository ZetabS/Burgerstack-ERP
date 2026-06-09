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
	
	.search-area select,
	.search-area input {
	    height: 36px;
	    border: 1px solid #d1d5db;
	    border-radius: 8px;
	    padding: 0 12px;
	    font-size: 14px;
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
	
	.info-box {
	    background: #f9fafb;
	    border: 1px solid #e5e7eb;
	    border-radius: 10px;
	    padding: 14px 18px;
	    margin-bottom: 18px;
	    font-size: 15px;
	}
	
	.table {
	    width: 100%;
	    border-collapse: collapse;
	    font-size: 15px;
	}
	
	.table thead th {
	    background: #f8fafc;
	    color: #374151;
	    font-weight: 700;
	    border-top: 1px solid #e5e7eb;
	    border-bottom: 2px solid #d1d5db;
	    padding: 14px 12px;
	}
	
	.table tbody td,
	.table tbody th {
	    border-bottom: 1px solid #e5e7eb;
	    padding: 14px 12px;
	    vertical-align: middle;
	}
	
	.table tbody tr:hover {
	    background: #fff7ed;
	}
	
	.table a {
	    color: #ff6b00;
	    font-weight: 600;
	    text-decoration: none;
	}
	
	.table a:hover {
	    text-decoration: underline;
	}
	
	.total-row th,
	.total-row td {
	    background: #f9fafb;
	    font-weight: 700;
	}
	
	.total-price {
	    color: #ff6b00;
	    font-size: 17px;
	}
	
	.clickable-row {
	    cursor: pointer;
	}
	
	.clickable-row:hover {
	    background: #fff7ed;
	    transition:0.2s;
	}
	
	.status-badge {
	    display:inline-block;
	    padding:5px 10px;
	    border-radius:20px;
	    background:#dcfce7;
	    color:#166534;
	    font-size:13px;
	    font-weight:600;
	}
	
	.table tbody tr:hover{
    background:#fff7ed;
    cursor:pointer;
}

.table-guide{
    font-size:13px;
    color:#888;
    margin-bottom:15px;
}

	</style>
</head>
<body>

    <t:layout>
        <h2>입고 이력</h2>
        
        <p class="table-guide">
	        행을 클릭하면 상세 정보를 확인할 수 있습니다.
	    </p>
        
        <!-- 검색 -->
        <div class="search-area" align="right">
            <select name="receiptStatus" id="receiptStatus">
                <option value="">전체</option>
                <option value="NORMAL">정상 입고</option>
                <option value="DEFECT">불량 입고</option>
            </select>

            <input type="date" name="startDate">
            ~
            <input type="date" name="endDate">

            <input type="text" name="keyword" placeholder="점포명 검색">

            <button type="button" onclick="alert('검색 기능은 나중에 연결')">
                <img src="${pageContext.request.contextPath}/resources/images/BS_logo2.png"
                     style="width: 16px;"/>
                검색
            </button>
        </div>

        <table class="table">
            <thead>
			    <tr>
			        <th>점포명</th>
			        <th>입고번호</th>
			        <th>발주번호</th>
			        <th>입고 메모</th>
			        <th>입고 완료일</th>
			    </tr>
			</thead>

            <tbody>
            	<c:forEach var="r" items="${list}">
				    <tr class="clickable-row"
				        onclick="location.href='${pageContext.request.contextPath}/admin/receipts/${r.receiptId}'">
				
				        <td>강남점</td>
				        <td>#${r.receiptId}</td>
				        <td>${r.purchaseOrderId}</td>
				        <td>
				            <span class="status-badge">
				                ${r.receiptMemo}
				            </span>
				        </td>
				        <td>
				            ${r.receivedAt.toString().replace('T',' ').substring(0,19)}
				        </td>
				    </tr>
				</c:forEach>
                

                <c:if test="${empty list}">
			        <tr>
			            <td colspan="5" align="center">입고 이력이 없습니다.</td>
			        </tr>
			    </c:if>
            </tbody>
        </table>

        <ui:pagination pageInfo="${pageInfo}"></ui:pagination>

    </t:layout>
</body>
</html>