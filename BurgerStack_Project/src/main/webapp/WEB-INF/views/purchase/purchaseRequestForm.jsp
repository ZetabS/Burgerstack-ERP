<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 요청 페이지 조회</title>
<jsp:include page="../common/header.jsp" />
</head>
<body>

<t:menubarBO>

    <h2>발주 요청 페이지</h2>
    
    <br>

    <form action="${pageContext.request.contextPath}/owner/purchases" method="post">
        <!-- 검색 / 필터 -->
        <div class="search-area" align="rignt">
            <select>
                <option hidden selected disabled>정렬 방식</option>
                <option>재고 부족순</option>
                <option>재고 많은순</option>
                <option>구매가 높은순</option>
                <option>구매가 낮은순</option>
                <option>발주 수량순</option>
            </select>

            <input type="text" placeholder="검색어 입력">
            <button class="search-btn">  
                    <img src="" alt="검색"/>
            </button>
        </div>

        <table class="table2">
            <thead>
                <tr>
                    <th>선택</th>
                    <th>품목</th>
                    <th>원가</th>
                    <th>재고</th>
                    <th>주문수량</th>
                    <th>구매가격</th>
                    <th>상태</th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td><input type="checkbox"></td>
                    <td>양상추</td>
                    <td>10000</td>
                    <td>3</td>
                    <td><input name="orderQuantity" type="number" value="0"></td>
                    <td>250000</td>
                    <td>판매중</td>
                </tr>
                <tr>
                    <td><input type="checkbox"></td>
                    <td>토마토</td>
                    <td>10000</td>
                    <td>8</td>
                    <td><input name="orderQuantity" type="number" value="0"></td>
                    <td>80000</td>
                    <td>판매중</td>
                </tr>
                <c:forEach var="m" items="${list}">
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>${m.materialName}</td>
                        <td>${m.costPrice}</td>
                        <td>${m.currentQuantity}</td>
                        <td><input name="orderQuantity" type="number" value="0"></td>
                        <td>${m.buyPrice}</td>
                        <td>
                            <c:choose>
                                <c:when test="${m.status eq 'ACTIVE'}">
                                    판매중
                                </c:when>
                                <c:otherwise>
                                    재고 부족
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="2">총 금액</td>
                    <td colspan="3"></td>
                    <td>
                        330,000원
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>

        <br>

        

        <div class="middle-area">
            <button class="button-primary"> 목록 </button>
            <button type="submit" class="button-primary"> 결제 </button>
        </div>

        <t:sidebar>
            <jsp:attribute name="sidebarTitle">
                주문리스트
            </jsp:attribute>
            <jsp:body>
                <table class="table2">
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>품목</th>
                            <th>주문수량</th>
                            <th>구매가격</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td><input type="checkbox"></td>
                            <td>양상추</td>
                            <td>25</td>
                            <td>250000</td>
                        </tr>

                        <tr>
                            <td><input type="checkbox"></td>
                            <td>토마토</td>
                            <td>8</td>
                            <td>80000</td>
                        </tr>
                    </tbody>
                </table>

                <div class="middle-area">
                    <p style="padding: 2px; text-align: center;">
                        <h5>TOTAL</h5>
                    </p>
                    <b><h3>330000원</h3></b>
                    <button class="button-primary"> 결제 </button>
                </div>
                
            </jsp:body>
        </t:sidebar>
    </form>
    

</t:menubarBO>


<script>
    $(document).ready(function() {
    // 1. 주문수량 변경 이벤트 감지 (input 값이 바뀔 때)
    $('input[name="orderQuantity"]').on('input change', function() {
        let $quantityInput = $(this);
        let $row = $quantityInput.closest('tr'); // 현재 행(row) 찾기
        let $checkbox = $row.find('input[type="checkbox"]');
        
        let quantity = parseInt($quantityInput.val());

        // [유효성 검사] 0 미만이거나 숫자가 아니면 0으로 초기화
        if (isNaN(quantity) || quantity < 0) {
            quantity = 0;
            $quantityInput.val(0);
        }

        // [체크박스 자동 선택] 1 이상이면 체크, 0이면 체크 해제
        if (quantity >= 1) {
            $checkbox.prop('checked', true);
        } else {
            $checkbox.prop('checked', false);
        }

        // 원가 정보를 바탕으로 구매가격 실시간 계산 (선택 사항)
        let unitPrice = parseInt($row.find('.unit-price').text().replace(/[^0-9]/g, '')) || 0;
        let totalPrice = unitPrice * quantity;
        $row.find('.total-price').text(totalPrice); // 메인 테이블의 구매가격 업데이트

        // 사이드바 주문리스트 업데이트 함수 호출
        updateSidebarOrderList();
    });

    // 2. 체크박스를 직접 클릭했을 때의 이벤트 처리
    $('input[type="checkbox"]').on('change', function() {
        let $checkbox = $(this);
        let $row = $checkbox.closest('tr');
        let $quantityInput = $row.find('input[name="orderQuantity"]');
        
        // 체크를 해제하면 수량을 0으로, 체크하면 최소 1로 설정
        if (!$checkbox.is(':checked')) {
            $quantityInput.val(0);
        } else {
            if (parseInt($quantityInput.val()) === 0) {
                $quantityInput.val(1);
            }
        }
        
        // 메인 테이블 구매가격 갱신 후 사이드바 업데이트
        let unitPrice = parseInt($row.find('.unit-price').text().replace(/[^0-9]/g, '')) || 0;
        let quantity = parseInt($quantityInput.val());
        $row.find('.total-price').text(unitPrice * quantity);

        updateSidebarOrderList();
    });
});

// 3. 사이드바(주문리스트) 및 최종 TOTAL 금액을 동적으로 갱신하는 함수
function updateSidebarOrderList() {
    let $sidebarTableBody = $('#sidebar-order-list tbody'); // 사이드바 테이블 body ID (구조에 맞게 수정 필요)
    let totalSum = 0;
    
    // 기존 사이드바 목록 비우기
    $sidebarTableBody.empty();

    // 메인 테이블에서 체크박스가 선택된 행들만 순회
    $('table.main-table tbody tr').each(function() {
        let $row = $(this);
        let isChecked = $row.find('input[type="checkbox"]').is(':checked');
        let quantity = parseInt($row.find('input[name="orderQuantity"]').val()) || 0;

        if (isChecked && quantity > 0) {
            let itemName = $row.find('.item-name').text().trim(); // 품목명
            let purchasePrice = parseInt($row.find('.total-price').text().replace(/[^0-9]/g, '')) || 0; // 구매가격
            
            totalSum += purchasePrice;

            // 사이드바 테이블에 행 추가
            let sidebarRow = `
                <tr>
                    <td><input type="checkbox" class="sidebar-item-check"></td>
                    <td>${itemName}</td>
                    <td>${quantity}</td>
                    <td>${purchasePrice.toLocaleString()}원</td>
                </tr>
            `;
            $sidebarTableBody.append(sidebarRow);
        }
    });

    // 메인 화면 및 사이드바의 TOTAL 금액 업데이트
    $('.main-total-amount').text(totalSum.toLocaleString() + "원");
    $('#sidebar-total-amount').text(totalSum.toLocaleString() + "원");

    /* [참고: 만약 백엔드 세션이나 장바구니 DB에 실시간 저장이 필요한 경우 Ajax 추가]
    let orderData = [];
    // 데이터를 배열로 추출하여 $.ajax() 로 서버에 전송하는 로직을 여기에 작성할 수 있습니다.
    */
}
</script>

</body>
</html>