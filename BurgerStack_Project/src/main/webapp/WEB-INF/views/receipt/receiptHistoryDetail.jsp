<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>   
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
	
	.info-box{
	    display:flex;
	    align-items:center;
	
	    padding:15px 20px;
	    margin-bottom:20px;
	
	    background:#f8fafc;
	    border:1px solid #e5e7eb;
	    border-radius:10px;
	
	    font-size:15px;
	}
	
	.info-box strong{
	    color:#374151;
	}
	
	.info-box {
	    margin-bottom: 20px;
	}
	
	.content-box {
	    min-height: auto !important;
	}
	
	.receipt-info{
	    display:flex;
	    gap:50px;
	    font-size:16px;
	    font-weight:500;
	}
	
	.table {
	    margin-top: 0;
	}
</style>
</head>
<body>
    <t:layout>
        <h2>입고 이력 상세 보기</h2>

        <!-- 검색 -->
        <div class="search-area" align="right">
            <select id="materialType" onchange="filterMaterialType(this.value)">
			    <option value="">자재 유형</option>
			    <option value="냉장">냉장</option>
			    <option value="냉동">냉동</option>
			</select>
            <input type="text" placeholder="검색어 입력">
            <button type="button" onclick="alert('클릭!')">
                <img src="..\..\resources\images\BS_logo2.png" style="width: 16px;"/>
                검색
            </button>                
        </div>
	
        <div class="receipt-info">
		    <span>입고 번호 : ${receipt.receiptId}</span>
		    <span>발주 번호 : ${receipt.purchaseOrderId}</span>
		    <span>입고 메모 : ${receipt.receiptMemo}</span>
		</div>
		            
        </div>
	        <table class="table">
	    <thead>
	        <tr>
	            <th>자재 코드</th>
	            <th>자재명</th>
	            <th>자재 유형</th>
	            <th>단가</th>
	            <th>요청 수량</th>
	            <th>실수령 수량</th>
	            <th>불량 수량</th>
	            <th>불량 사유</th>
	            <th>금액</th>
	        </tr>
	    </thead>
	
	    <tbody>
	        <c:set var="totalPrice" value="0" />
	
	        <c:forEach var="item" items="${itemList}">
	            <tr data-type="${item.materialType}">
	                <td>${item.materialCode}</td>
	                <td>${item.materialName}</td>
	                <td>${item.materialType}</td>
	                <td>${item.supplyPrice}</td>
	                <td>${item.requestQuantity}</td>
	                <td>${item.receivedQuantity}</td>
	                <td>${item.defectQuantity}</td>
	                <td>
	                    <c:choose>
	                        <c:when test="${empty item.receiptItemMemo}">
	                            -
	                        </c:when>
	                        <c:otherwise>
	                            ${item.receiptItemMemo}
	                        </c:otherwise>
	                    </c:choose>
	                </td>
	                <td class="price">${item.amount}</td>
	            </tr>
	
	            <c:set var="totalPrice" value="${totalPrice + item.amount}" />
	        </c:forEach>
	
	        <tr class="total-row">
	            <th>총금액</th>
	            <td colspan="8" align="right">
	                <span id="totalPrice" class="total-price">${totalPrice}원</span>
	            </td>
	        </tr>
	    </tbody>
	</table>
	</t:layout>
	
	<script>
		function filterMaterialType(type) {
		
		    if(type === undefined){
		        type = document.getElementById("materialType").value;
		    }
		
		    var row1 = document.getElementById("row1");
		    var row2 = document.getElementById("row2");
		    var row3 = document.getElementById("row3");
		
		    var total = 0;
		
		    row1.style.display = "table-row";
		    row2.style.display = "table-row";
		    row3.style.display = "table-row";
		
		    if(type === "냉장"){
		
		        row3.style.display = "none";
		
		        total += 6400;
		        total += 6400;
		    }
		    else if(type === "냉동"){
		
		        row1.style.display = "none";
		        row2.style.display = "none";
		
		        total += 4000;
		    }
		    else{
		
		        total += 6400;
		        total += 6400;
		        total += 4000;
		    }
		
		    document.getElementById("totalPrice").innerText =
		        total.toLocaleString() + "원";
		}
		</script>
</body>
</html>