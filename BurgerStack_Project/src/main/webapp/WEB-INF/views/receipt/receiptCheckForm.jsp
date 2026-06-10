<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
    table input {
        width: 50px;
    }
</style>
</head>

<body>
<t:layout>

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
                <c:choose>
                    <c:when test="${empty itemList}">
                        <tr>
                            <td colspan="9" align="center">
                                입고 처리할 품목이 없습니다.
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:set var="totalAmount" value="0" />

                        <c:forEach var="item" items="${itemList}" varStatus="status">

							<tr>
							
							    <td>${item.materialCode}</td>
							    <td>${item.materialType}</td>
							    <td>${item.materialName}</td>
							
							    <!-- 발주수량 -->
							    <td>${item.approvedQuantity}</td>
							
							    <input type="hidden"
							           name="items[${status.index}].purchaseOrderItemId"
							           value="${item.purchaseOrderItemId}">
							
							    <!-- 입고수량 -->
							    <td>
							        <input type="number"
							               name="items[${status.index}].receivedQuantity"
							               value="${item.approvedQuantity}">
							    </td>
							
							    <!-- 불량수량 -->
							    <td>
							        <input type="number"
							               name="items[${status.index}].defectQuantity"
							               value="0">
							    </td>
							
							    <!-- 불량사유 -->
							    <td>
							        <select name="items[${status.index}].receiptItemMemo" disabled>
							            <option value="">선택</option>
							            <option value="파손">파손</option>
							            <option value="유통기한 임박">유통기한 임박</option>
							            <option value="변질">변질</option>
							            <option value="오배송">오배송</option>
							            <option value="미배송">미배송</option>
							        </select>
							    </td>
							
							    <!-- 단가 -->
							    <td>${item.supplyPrice}원</td>
							
							    <!-- 금액 -->
							    <td>${item.amount}원</td>
							
							</tr>
							
							</c:forEach>

                        <tr>
                            <th>총 금액</th>
                            <td align="right" colspan="8">
                                ${totalAmount}원
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <button type="reset">초기화</button>
        <button type="submit">저장</button>
    </form>

</t:layout>

	<script>
	    $(document).on('input change', 'input[name$=".defectQuantity"]', function() {
	
	        let $row = $(this).closest('tr');
	        let $reasonSelect = $row.find('select[name$=".receiptItemMemo"]');
	        let defectQty = parseInt($(this).val());
	
	        if (isNaN(defectQty)) {
	            defectQty = 0;
	        }
	
	        if (defectQty < 0) {
	            defectQty = 0;
	            $(this).val(0);
	        }
	
	        if (defectQty >= 1) {
	            $reasonSelect.prop('disabled', false);
	            $reasonSelect.prop('required', true);
	        } else {
	            $reasonSelect.val('');
	            $reasonSelect.prop('disabled', true);
	            $reasonSelect.prop('required', false);
	        }
	    });
	
	    $('form').on('submit', function(e) {
	
	        let valid = true;
	
	        $('input[name$=".defectQuantity"]').each(function() {
	
	            let $row = $(this).closest('tr');
	            let defectQty = parseInt($(this).val());
	            let $reasonSelect = $row.find('select[name$=".receiptItemMemo"]');
	
	            if (isNaN(defectQty)) {
	                defectQty = 0;
	            }
	
	            if (defectQty >= 1 && !$reasonSelect.val()) {
	                alert('불량수량이 있는 품목은 불량사유를 선택해야 합니다.');
	                $reasonSelect.focus();
	                valid = false;
	                return false;
	            }
	        });
	
	        if (!valid) {
	            e.preventDefault();
	        }
	    });
	</script>

</body>
</html>