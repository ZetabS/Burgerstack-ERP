<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	
	.receive-info {
	    margin-bottom: 20px;
	}
	
	.table {
	    margin-top: 0;
	}
</style>
</head>
<body>

<t:layout>

    <h2>입고 이력 상세 보기</h2>

    <div class="search-area" align="right">

        <select id="materialType" onchange="filterMaterialType(this.value)">
		    <option value="">자재 유형</option>
		    <option value="냉장">냉장</option>
		    <option value="냉동">냉동</option>
		</select>

        <input type="text" placeholder="검색어 입력">

        <button type="button" onclick="filterMaterialType()">
            <img src="${pageContext.request.contextPath}/resources/images/BS_logo2.png"
                 style="width:16px;">
            검색
        </button>

    </div>

    <div class="receive-info">
        <table>
            <tr>
                <td>입고 번호 : ${receiptId}</td>
                <td>승인 담당자 : -</td>
            </tr>
        </table>
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

            <tr id="row1" data-type="냉장">
                <td>FF133</td>
                <td>토마토</td>
                <td>냉장</td>
                <td>640</td>
                <td>10</td>
                <td>10</td>
                <td>0</td>
                <td>-</td>
                <td class="price">6400</td>
            </tr>

            <tr id="row2" data-type="냉장">
                <td>FF123</td>
                <td>양상추</td>
                <td>냉장</td>
                <td>640</td>
                <td>10</td>
                <td>12</td>
                <td>0</td>
                <td>-</td>
                <td class="price">6400</td>
            </tr>

            <tr id="row3" data-type="냉동">
                <td>ICE121</td>
                <td>레귤러 번</td>
                <td>냉동</td>
                <td>500</td>
                <td>10</td>
                <td>8</td>
                <td>2</td>
                <td>변질</td>
                <td class="price">4000</td>
            </tr>

            <tr>
			    <th>총금액</th>
			    <td colspan="8" align="right">
			        <span id="totalPrice">16800원</span>
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