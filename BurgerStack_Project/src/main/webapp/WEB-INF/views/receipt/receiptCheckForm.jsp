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
                        <td><input type="number" id="badStuff"></td>
                        <td>
                            <select id="badReason" disabled>
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
                        <td><input type="number" id="badStuff"></td>
                        <td>
                            <select id="badReason" disabled>
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
        $(document).ready(function() {
            // #badStuff 입력창의 값이 변경될 때마다 실행
            $('#badStuff').on('input', function() {
                // 입력된 값을 숫자로 변환 (빈 값일 경우 0 처리)
                var badCount = parseInt($(this).val()) || 0;

                // 7번째 td '안에 있는' select 태그를 찾습니다.
                var $selectBox = $('.table td').find('select');

                if (badCount > 0) {
                    // 불량수량이 0보다 크면 비활성화 해제
                    $selectBox.attr('disabled', false);
                } else {
                    // 값이 0 이하이면 다시 비활성화
                    $selectBox.prop('disabled', true);
                }
            });
        });
    </script>
</body>
</html>