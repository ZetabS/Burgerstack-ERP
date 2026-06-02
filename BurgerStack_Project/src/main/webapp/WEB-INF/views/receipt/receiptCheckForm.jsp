<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common/header.jsp" />
<style>
    table input{
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
                <img src="..\..\resources\images\BS_logo2.png" style="width: 16px;"/>
                검색
            </button>                
        </div>
        <!-- 입고 정보 -->
        <div class="receive-info">
            <table>
                <tr>
                    <td>
                        발주번호 : ${requestScope.receiveId}
                    </td>
                    <td>
                        요청일 : ${requestScope.receiveDate}
                    </td>
                </tr>
            </table>
        </div>
        <!-- 입고 처리 데이터 표시 -->
        <form action="" method="post" align="center">
            <table class="table" align="center">
                <thead>
                    <tr>
                        <th>상품코드</th>
                        <th>상품유형</th>
                        <th>상품명</th>
                        <th>발주수량</th>
                        <th>입고수량</th>
                        <th>불량수량</th>
                        <th>불량사유</th> <!-- 불량수량이 1 이상 일 때 표시 -->
                        <th>단가</th>
                        <th>금액</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>FF123</td>
                        <td>냉장</td>
                        <td>양상추</td>
                        <td>20</td>
                        <td><input type="number" id="inputStuff"></td>
                        <td><input type="number" name="defect_quantity" min="0"></td>
                        <td>
                            <select name="defect_reason" disabled>
                                <option value="" hidden selected disabled>선택</option>
                                <option>파손</option>
                                <option>유통기한 임박</option>
                                <option>변질</option>
                                <option>오배송</option>
                            </select>
                        </td>
                        <td>3200원</td>
                        <td>64000원</td>
                    </tr>
                    <tr>
                        <td>FF123</td>
                        <td>냉장</td>
                        <td>양상추</td>
                        <td>20</td>
                        <td><input type="number" id="inputStuff"></td>
                        <td><input type="number" name="defect_quantity" min="0"></td>
                        <td>
                            <select name="defect_reason" disabled>
                                <option value="" hidden selected disabled>선택</option>
                                <option>파손</option>
                                <option>유통기한 임박</option>
                                <option>변질</option>
                                <option>오배송</option>
                            </select>
                        </td>
                        <td>3200원</td>
                        <td>64000원</td>
                    </tr>
                    <tr>
                        <th>총 금액</th>
                        <td align="right" colspan="7">128000원</td>
                    </tr>
                </tbody>
            </table>

            <button type="reset">초기화</button>
            <button type="submit">저장</button>
        </form>
        

	</t:menubarBO>

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
    </script>
</body>
</html>