<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common/header.jsp" />

<style>
    table input {
        width: 50px;
    }
</style>
</head>

	<body>
	<t:menubarBO>
	
	    <h2>입고 처리</h2>
	
	    <!-- 검색 -->
	    <div class="search-area" align="right">
	        <select name="type" id="materialsType">
	            <option>전체</option>
	            <option>상온</option>
	            <option>냉장</option>
	            <option>냉동</option>
	            <option>건자재</option>
	        </select>
	
	        <input type="text" placeholder="검색어 입력">
	
	        <button type="button" onclick="alert('클릭!')">
	            <img src="${pageContext.request.contextPath}/resources/images/BS_logo2.png"
	                 style="width: 16px;" />
	            검색
	        </button>
	    </div>
	
	    <!-- 입고 정보 -->
	    <div class="receive-info">
	        <table>
	            <tr>
	                <td>발주번호 : ${purchaseId}</td>
	                <td>요청일 : ${requestScope.receiveDate}</td>
	            </tr>
	        </table>
	    </div>
	
	    <!-- 입고 처리 데이터 표시 -->
	    <form action="${pageContext.request.contextPath}/owner/purchases/${purchaseId}/receipt"
	          method="post"
	          align="center">
	
	        <table class="table" align="center">
	            <thead>
	                <tr>
	                    <th>상품코드</th>
	                    <th>상품유형</th>
	                    <th>상품명</th>
	                    <th>발주수량</th>
	                    <th>입고수량</th>
	                    <th>불량수량</th>
	                    <th>불량사유</th>
	                    <th>단가</th>
	                    <th>금액</th>
	                </tr>
	            </thead>
	
	            <tbody>
	                <!-- 1번째 상품 -->
	                <tr>
	                    <td>FF123</td>
	                    <td>냉장</td>
	                    <td>양상추</td>
	                    <td>20</td>
	
	                    <!-- 실제 DB의 PURCHASE_ORDER_ITEM_ID 값이어야 함 -->
	                    <input type="hidden"
	                           name="items[0].purchaseOrderItemId"
	                           value="11">
	
	                    <td>
	                        <input type="number"
	                               name="items[0].receivedQuantity"
	                               min="0"
	                               value="20">
	                    </td>
	
	                    <td>
	                        <input type="number"
	                               name="items[0].defectQuantity"
	                               min="0"
	                               value="0">
	                    </td>
	
	                    <td>
	                        <select name="items[0].receiptItemMemo" disabled>
	                            <option value="" hidden selected disabled>선택</option>
	                            <option value="파손">파손</option>
	                            <option value="유통기한 임박">유통기한 임박</option>
	                            <option value="변질">변질</option>
	                            <option value="오배송">오배송</option>
	                            <option value="미배송">미배송</option>
	                        </select>
	                    </td>
	
	                    <td>3200원</td>
	                    <td>64000원</td>
	                </tr>
	
	                <!-- 2번째 상품 -->
	                <tr>
	                    <td>FF123</td>
	                    <td>냉장</td>
	                    <td>양상추</td>
	                    <td>20</td>
	
	                    <!-- 실제 DB의 PURCHASE_ORDER_ITEM_ID 값이어야 함 -->
	                    <input type="hidden"
	                           name="items[1].purchaseOrderItemId"
	                           value="12">
	
	                    <td>
	                        <input type="number"
	                               name="items[1].receivedQuantity"
	                               min="0"
	                               value="20">
	                    </td>
	
	                    <td>
	                        <input type="number"
	                               name="items[1].defectQuantity"
	                               min="0"
	                               value="0">
	                    </td>
	
	                    <td>
	                        <select name="items[1].receiptItemMemo" disabled>
	                            <option value="" hidden selected disabled>선택</option>
	                            <option value="파손">파손</option>
	                            <option value="유통기한 임박">유통기한 임박</option>
	                            <option value="변질">변질</option>
	                            <option value="오배송">오배송</option>
	                            <option value="미배송">미배송</option>
	                        </select>
	                    </td>
	
	                    <td>3200원</td>
	                    <td>64000원</td>
	                </tr>
	
	                <tr>
	                    <th>총 금액</th>
	                    <td align="right" colspan="8">128000원</td>
	                </tr>
	            </tbody>
	        </table>
	
	        <button type="reset">초기화</button>
	        <button type="submit">저장</button>
	    </form>
	
	</t:menubarBO>
	
	<script>
	    // 불량수량 입력창의 값이 변경될 때마다 실행
	    $(document).on('input change', 'input[name$=".defectQuantity"]', function() {
	
	        let $row = $(this).closest('tr');
	        let $reasonSelect = $row.find('select[name$=".receiptItemMemo"]');
	        let defectQty = parseInt($(this).val());
	
	        // 빈 값이거나 숫자가 아닌 경우 0으로 처리
	        if (isNaN(defectQty)) {
	            defectQty = 0;
	        }
	
	        // 불량수량이 0 미만이면 0으로 고정
	        if (defectQty < 0) {
	            defectQty = 0;
	            $(this).val(0);
	        }
	
	        // 불량수량이 1 이상일 때만 불량사유 활성화
	        if (defectQty >= 1) {
	            $reasonSelect.prop('disabled', false);
	        } else {
	            $reasonSelect.val('').prop('disabled', true);
	        }
	    });
	</script>
	
	</body>
</html>