<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    table input{
        width: 50px;
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
        <h2>발주 처리</h2>

        <div class="content-top">
            <!-- 발주 정보 간이 -->
            <div class="top-info">
                <div><b>발주번호 :</b> ${list[0].purchaseOrderId}</div>
                <div><b>요청일 :</b> ${list[0].createdAt}</div>
            </div>
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
                    <img src="..\..\resources\images\BS_logo2.png" style="width: 16px;"/>
                    검색
                </button>                
            </div>
        </div>

        <!-- 입고 처리 데이터 표시 -->
        <form action="" method="post" align="center">
            <table class="table" align="center">
                <thead>
                    <tr>
                        <th>상품코드</th>
                        <th>상품유형</th>
                        <th>상품명</th>
                        <th>요청수량</th>
                        <th>승인수량</th>
                        <th>반려수량</th>
                        <th>반려사유</th> <!-- 반려수량이 1 이상 일 때 표시 -->
                        <th>단가</th>
                        <th>금액</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${list}" varStatus="s">

                    <input type="hidden"
                            name="items[${s.index}].materialId"
                            value="${item.materialId}">
                    
                    <input type="hidden"
                            name="items[${s.index}].requestQuantity"
                            value="${item.requestQuantity}">

                    <tr>

                        <!-- 상품코드 -->
                        <td>${item.materialId}</td>

                        <!-- 상품유형 -->
                        <td>${item.materialType}</td>

                        <!-- 상품명 -->
                        <td>${item.materialName}</td>

                        <!-- 요청수량 -->
                        <td class="requestQty">${item.requestQuantity}</td>

                        <!-- 승인수량 -->
                        <td>
                            <input type="number"
                                class="approvedQty"
                                name="items[${s.index}].approvedQuantity"
                                value="${item.requestQuantity}"
                                min="0">
                        </td>

                        <!-- 반려수량 -->
                        <td>
                            <input type="number"
                                class="rejectQty"
                                name="items[${s.index}].rejectQuantity"
                                value="0"
                                min="0">
                        </td>

                        <!-- 반려사유 -->
                        <td>
                            <select
                                class="reason"
                                name="items[${s.index}].rejectReason"
                                disabled>

                                <option value="">선택</option>
                                <option value="재고부족">재고부족</option>
                                <option value="품절">품절</option>
                                <option value="공급중단">공급중단</option>
                                <option value="기타">기타</option>

                            </select>
                        </td>

                        <!-- 단가 -->
                        <td>${item.supplyPriceSnapshot}</td>

                        <!-- 금액 -->
                        <td class="itemPrice"
                            data-unit-price="${item.supplyPriceSnapshot}">
                            ${item.totalPrice}
                        </td>

                    </tr>

                    </c:forEach>



                    <tr>
                        <th>총 금액</th>
                        <td align="right" colspan="8" id="totalAmount">0원</td>
                    </tr>
                </tbody>
            </table>

            <button type="reset">초기화</button>
            <button type="submit" id="confirmBtn">
                결재
            </button>
        </form>
        

	</t:layout>

    <script>
        // 페이지 로드 시 실행
        $(function(){

            $('.rejectQty').each(function(){

                const row = $(this).closest('tr');

                toggleReason(row);
                updateAmount(row);

            });

        });
        // =================================
        // 승인수량 변경
        // =================================
        $(document).on('input', '.approvedQty', function () {

            const row = $(this).closest('tr');

            const requestQty =
                Number(row.find('.requestQty').text()) || 0;

            let approvedQty =
                Number($(this).val()) || 0;

            if (approvedQty < 0) {
                approvedQty = 0;
            }

            if (approvedQty > requestQty) {
                approvedQty = requestQty;
            }

            $(this).val(approvedQty);

            const rejectQty =
                requestQty - approvedQty;

            row.find('.rejectQty').val(rejectQty);

            toggleReason(row);
            updateAmount(row);
        });


        // =================================
        // 반려수량 변경
        // =================================
        $(document).on('input', '.rejectQty', function () {

            const row = $(this).closest('tr');

            const requestQty =
                Number(row.find('.requestQty').text()) || 0;

            let rejectQty =
                Number($(this).val()) || 0;

            if (rejectQty < 0) {
                rejectQty = 0;
            }

            if (rejectQty > requestQty) {
                rejectQty = requestQty;
            }

            $(this).val(rejectQty);

            const approvedQty =
                requestQty - rejectQty;

            row.find('.rejectQty').val(rejectQty);

            toggleReason(row);
            updateAmount(row);
        });


        // =================================
        // 반려사유 활성화
        // =================================
        function toggleReason(row){

            const rejectQty =
                Number(row.find('.rejectQty').val()) || 0;

            const reasonSelect =
                row.find('.reason');

            if(rejectQty > 0){

                reasonSelect
                    .prop('disabled', false)
                    .prop('required', true);

            }else{

                reasonSelect
                    .val('')
                    .prop('required', false)
                    .prop('disabled', true);
            }
        }
        // =================================
        // 금액 계산
        // =================================
        function updateAmount(row){

            const approvedQty =
                Number(row.find('.approvedQty').val()) || 0;

            const priceCell =
                row.find('.itemPrice');

            const unitPrice =
                Number(priceCell.data('unit-price')) || 0;

            const amount =
                approvedQty * unitPrice;

            priceCell.text(
                amount.toLocaleString() + '원'
            );

            updateTotalAmount();
        }

        // =================================
        // 총 금액 계산
        // =================================
        function updateTotalAmount(){

            let total = 0;

            $('.itemPrice').each(function(){

                const approvedQty =
                    Number(
                        $(this)
                        .closest('tr')
                        .find('.approvedQty')
                        .val()
                    ) || 0;

                const unitPrice =
                    Number($(this).data('unit-price')) || 0;

                total += approvedQty * unitPrice;
            });

            $('#totalAmount').text(
                total.toLocaleString() + '원'
            );
        }
        
        // ===============================
        // 결재 전 검증 + 최종 확인
        // ===============================
        $('form').on('submit', function(e){

            let valid = true;

            $('.rejectQty').each(function(){

                const row = $(this).closest('tr');

                const rejectQty =
                    Number($(this).val()) || 0;

                const reason =
                    row.find('.reason').val();

                // 반려수량이 있는데 사유 미선택
                if(rejectQty > 0 && !reason){

                    alert('반려수량이 있는 경우 반려사유를 선택해야 합니다.');

                    row.find('.reason').focus();

                    valid = false;

                    return false;
                }
            });

            if(!valid){
                e.preventDefault();
                return;
            }

            // 최종 결재 확인
            const result = confirm(
                '발주를 결재하시겠습니까?\n\n결재 후에는 처리 상태가 변경됩니다.'
            );

            if(!result){
                e.preventDefault();
            }
        });
    </script>
</body>
</html>