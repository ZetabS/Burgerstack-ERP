<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	
	.receive-info {
	    margin-bottom: 20px;
	    background: #f8fafc;
	    border: 1px solid #e5e7eb;
	    border-radius: 10px;
	    padding: 15px 20px;
	    font-size: 15px;
	}
	
	.receive-info table {
	    width: 100%;
	}
	
	.receive-info td {
	    padding: 6px 10px;
	}
	
	.table {
	    width: 100%;
	    border-collapse: collapse;
	    font-size: 15px;
	    margin-top: 0;
	}
	
	.table thead th {
	    background: #f8fafc;
	    color: #374151;
	    font-weight: 700;
	    border-top: 1px solid #e5e7eb;
	    border-bottom: 2px solid #d1d5db;
	    padding: 14px 12px;
	    text-align: center;
	}
	
	.table tbody td,
	.table tbody th {
	    border-bottom: 1px solid #e5e7eb;
	    padding: 14px 12px;
	    vertical-align: middle;
	    text-align: center;
	}
	
	.table tbody tr:hover {
	    background: #fff7ed;
	}
	
	.total-row th,
	.total-row td {
	    background: #f9fafb;
	    font-weight: 700;
	}
	
	.total-price {
	    color: #ff6b00;
	    font-size: 17px;
	    font-weight: 700;
	}
	
	.content-box {
	    min-height: auto !important;
	}

	.btn-area {
	    margin-top: 24px;
	    text-align: center;
	}

	.list-btn {
	    display: inline-block;
	    padding: 9px 18px;
	    background: #374151;
	    color: #fff !important;
	    border-radius: 8px;
	    font-size: 14px;
	    font-weight: 600;
	    text-decoration: none !important;
	}

	.list-btn:hover {
	    background: #1f2937;
	    color: #fff !important;
	    text-decoration: none !important;
	}
</style>
</head>

<body>

<t:layout>

    <h2 class="page-title">입고 이력 상세 보기</h2>

    <!-- 검색 -->
    <div class="search-area">
        <input type="text"
               id="keyword"
               placeholder="검색어 입력"
               onkeyup="filterReceiptItems()">

        <button type="button" onclick="filterReceiptItems()">
            검색
        </button>
    </div>

    <!-- 입고 정보 -->
    <div class="receive-info">
	    <table>
	        <tr>
	            <td>입고 번호 : ${receipt.receiptId}</td>
	            <td>발주 번호 : ${receipt.purchaseOrderId}</td>
	        </tr>
	        <tr>
	            <td>입고 완료일 : ${fn:replace(receipt.receivedAt, 'T', ' ')}</td>
	            <td>승인 담당자 : -</td>
	        </tr>
	        <tr>
	            <td colspan="2">입고 메모 : ${receipt.receiptMemo}</td>
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

            <c:choose>
                <c:when test="${empty itemList}">
                    <tr>
                        <td colspan="9">입고 상세 내역이 없습니다.</td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="item" items="${itemList}">
                        <tr class="item-row"
                            data-keyword="${item.materialCode} ${item.materialName} ${item.materialType}">

                            <td>${item.materialCode}</td>
                            <td>${item.materialName}</td>
                            <td>${item.materialType}</td>

                            <td>
                                <fmt:formatNumber value="${item.supplyPrice}" pattern="#,###" />
                            </td>

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

                            <td class="price" data-price="${item.amount}">
                                <fmt:formatNumber value="${item.amount}" pattern="#,###" />
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <tr class="total-row">
			    <th>총금액</th>
			    <td colspan="8" align="right">
			        <span id="totalPrice" class="total-price">0원</span>
			    </td>
			</tr>

        </tbody>
    </table>

    <div class="btn-area">
        <a class="list-btn"
           href="${pageContext.request.contextPath}/admin/receipts">
            목록으로
        </a>
    </div>

</t:layout>

<script>
function filterReceiptItems() {

    var keywordInput = document.getElementById("keyword");
    var totalPrice = document.getElementById("totalPrice");

    if (!keywordInput) {
        return;
    }

    var keyword = keywordInput.value.toLowerCase();
    var rows = document.querySelectorAll(".item-row");

    var total = 0;

    rows.forEach(function(row) {

        var rowKeyword = row.getAttribute("data-keyword").toLowerCase();

        if (keyword === "" || rowKeyword.includes(keyword)) {

            row.style.display = "table-row";

            var price = row.querySelector(".price").getAttribute("data-price");
            total += Number(price || 0);

        } else {

            row.style.display = "none";

        }
    });

    if (totalPrice) {
        totalPrice.innerText = total.toLocaleString() + "원";
    }
}

document.addEventListener("DOMContentLoaded", function() {
    filterReceiptItems();
});
</script>

</body>
</html>