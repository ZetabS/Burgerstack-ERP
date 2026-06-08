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
<style>
        .disabled-row {
        opacity: 0.5;
        pointer-events: none;
    }
</style>
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

        <table class="table2 main-table">
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
                <c:forEach var="m" items="${list}">
                    <c:if test="${m.status ne 'ACTIVE'}">
                        <tr class="item-row" data-id="${m.materialId}">
                            <td>
                                <input type="checkbox" class="row-check">
                            </td>
                            <td class="item-name">${m.materialName}</td>
                            <td class="unit-price">${m.costPrice}</td>
                            <td class="stock">${m.currentQuantity}</td>
                            <td>
                                <input type="number" class="qty-input" value="0" min="0">
                            </td>
                            <td class="total-price">0</td>
                            <td class="status">${m.status}</td>
                        </tr>
                    </c:if>
                    <c:if test="${m.status eq 'ACTIVE'}">
                        <tr class="item-row" data-id="${m.materialId}">
                            <td>
                                <input type="checkbox" class="row-check">
                            </td>
                            <td class="item-name">${m.materialName}</td>
                            <td class="unit-price">${m.costPrice}</td>
                            <td class="stock">${m.currentQuantity}</td>
                            <td>
                                <input type="number" class="qty-input" value="0" min="0">
                            </td>
                            <td class="total-price">0</td>
                            <td class="status">${m.status}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                <tr>
                    <td colspan="2">총 금액</td>
                    <td colspan="3"></td>
                    <td>
                        <h3 class="main-total-amount">0원</h3>
                    </td>
                </tr>
            </tbody>
        </table>

        <input type="hidden" name="itemsJson" id="itemsJson">

        <br>

        

        <div class="middle-area">
            <button type="button" class="button-primary" onclick="location.href = '${pageContext.request.contextPath}/owner/purchases'"> 목록 </button>
            <button type="submit" class="button-primary" onclick="buildJson()"> 결제 </button>
        </div>

        <t:sidebar>
            <jsp:attribute name="sidebarTitle">
                주문리스트
            </jsp:attribute>
            <jsp:body>
                <table class="table2" id="sidebar-order-list">
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>품목</th>
                            <th>주문수량</th>
                            <th>구매가격</th>
                        </tr>
                    </thead>

                    <tbody>

                    </tbody>
                </table>

                <div class="middle-area">
                    <p style="padding: 2px; text-align: center;">
                        <h5>TOTAL</h5>
                    </p>
                    <b><h3 id="sidebar-total-amount">0원</h3></b>
                    <button class="button-primary" type="submit"> 결제 </button>
                </div>
            </jsp:body>
        </t:sidebar>
    </form>
    

</t:menubarBO>


<script>
        $(document).ready(function () {

    // =========================
    // 1. 수량 변경
    // =========================
    $('.qty-input').on('input', function () {

        let $row = $(this).closest('.item-row');

        let qty = parseInt($(this).val()) || 0;
        if (qty < 0) qty = 0;

        let price = parseInt($row.find('.unit-price').text()) || 0;

        let total = qty * price;

        $row.find('.total-price').text(total);

        // 체크 자동
        $row.find('.row-check').prop('checked', qty > 0);

        updateSidebar();
    });


    // =========================
    // 2. 체크박스 변경
    // =========================
    $('.row-check').on('change', function () {

        let $row = $(this).closest('.item-row');
        let $qty = $row.find('.qty-input');

        if ($(this).is(':checked')) {
            if (parseInt($qty.val()) === 0) {
                $qty.val(1);
            }
        } else {
            // ❗ 체크 해제 시 완전 초기화
            $qty.val(0);
        }

        let price = parseInt($row.find('.unit-price').text()) || 0;
        let qty = parseInt($qty.val()) || 0;

        $row.find('.total-price').text(price * qty);

        updateSidebar();
    });


    // =========================
    // 3. 사이드바 업데이트
    // =========================
    function updateSidebar() {

        let $tbody = $('#sidebar-order-list tbody');
        $tbody.empty();

        let total = 0;

        $('.item-row').each(function () {

            let $row = $(this);

            let checked = $row.find('.row-check').is(':checked');
            let qty = parseInt($row.find('.qty-input').val()) || 0;

            if (!checked || qty <= 0) return;

            let name = $row.find('.item-name').text().trim();
            let price = parseInt($row.find('.unit-price').text()) || 0;

            total += price;

            // ✔ 사이드바 출력
            $tbody.append(`
                <tr class="sidebar-row">
                    <td>
                        <input type="checkbox" class="sidebar-check" checked>
                    </td>
                    <td>${name}</td>
                    <td>${qty}</td>
                    <td>${price.toLocaleString()}원</td>
                </tr>
            `);
        });

        $('.main-total-amount').text(total.toLocaleString() + "원");
        $('#sidebar-total-amount').text(total.toLocaleString() + "원");

        $('#totalAmountInput').val(total);
    }


    // =========================
    // 4. 사이드바 체크 이벤트 (핵심 추가)
    // =========================
    $(document).on('change', '.sidebar-check', function () {

        let index = $(this).closest('tr').index();

        let $mainRow = $('.item-row').filter(function () {
            return $(this).find('.item-name').text() ===
                   $(this).closest('tr').find('.item-name').text();
        });

        let name = $(this).closest('tr').find('td:nth-child(2)').text();

        // 메인 row 찾기
        $('.item-row').each(function () {

            let $row = $(this);

            if ($row.find('.item-name').text().trim() === name) {

                // ❗ 동기화 핵심
                $row.find('.row-check').prop('checked', false);
                $row.find('.qty-input').val(0);
                $row.find('.total-price').text(0);
            }
        });

        updateSidebar();
    });

});

function buildJson() {

    let items = [];

    $('.item-row').each(function () {

        let checked = $(this).find('.row-check').is(':checked');
        let qty = parseInt($(this).find('.qty-input').val()) || 0;

        if (!checked || qty <= 0) return;

        items.push({
            materialId: $(this).data('id'),
            materialNameSnapshot: $(this).find('.item-name').text().trim(),
            unitPriceSnapshot: parseInt($(this).find('.unit-price').text()),
            requestQuantity: parseInt($(this).find('.qty-input').val()) || 0
        });
    });

    $('#itemsJson').val(JSON.stringify(items));
}
</script>

</body>
</html>
