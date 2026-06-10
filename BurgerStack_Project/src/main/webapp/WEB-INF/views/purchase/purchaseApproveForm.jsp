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

                    <tr>

                        <!-- 상품코드 -->
                        <td>${item.materialId}</td>

                        <!-- 상품유형 (없으면 임시) -->
                        <td>-</td>

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
                            <input type="text"
                                class="reason"
                                name="items[${s.index}].rejectReason"
                                disabled>
                        </td>

                        <!-- 단가 -->
                        <td>${item.supplyPriceSnapshot}</td>

                        <!-- 금액 -->
                        <td>${item.totalPrice}</td>

                    </tr>

                    </c:forEach>

                    <tr>
                        <th>총 금액</th>
                        <td align="right" colspan="8">0원</td>
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
        // 불량수량 입력창의 값이 변경될 때마다 실행
        $(document).on('input change', 'input[name="defect_quantity"]', function() {
            let $row = $(this).closest('tr'); // 현재 행(row) 찾기
            let $reasonSelect = $row.find('select[name="defect_reason"]'); // 불량사유 select
            let defectQty = parseInt($(this).val());

            // 1) 빈 값이거나 숫자가 아닌 경우 0으로 처리
            if (isNaN(defectQty)) {
                defectQty = 0;
            }

            // 2) [핵심 추가] 불량수량이 0 미만으로 내려가려고 하면 0으로 강제 고정
            if (defectQty < 0) {
                defectQty = 0;
                $(this).val(0); // input창의 값도 0으로 변경
            }

            // 3) 조건에 따른 불량사유 select 제어
            if (defectQty >= 1) {
                // 불량 수량이 1 이상일 때만 활성화
                $reasonSelect.prop('disabled', false);
            } else {
                // 0일 때는 비활성화 및 '선택'으로 변경
                $reasonSelect.val('').prop('disabled', true); 
            }
        });

        $('.approvedQty').on('input', function() {

            const row = $(this).closest('tr');

            const requestQty = Number(
                row.find('.requestQty').text()
            );

            const approvedQty = Number($(this).val());

            if (approvedQty < requestQty) {
                row.find('.reason').prop('disabled', false);
            } else {
                row.find('.reason').val('');
                row.find('.reason').prop('disabled', true);
            }
        });

        $(document).on('input', '.approvedQty, .rejectQty', function () {

            const row = $(this).closest('tr');

            const requestQty = Number(row.find('.requestQty').text()) || 0;
            const approvedQty = Number(row.find('.approvedQty').val()) || 0;
            const rejectQty = Number(row.find('.rejectQty').val()) || 0;

            // 합계 초과 방지
            if (approvedQty + rejectQty > requestQty) {
                alert("요청수량을 초과할 수 없습니다.");

                $(this).val(0);
                return;
            }
        });
    </script>
</body>
</html>