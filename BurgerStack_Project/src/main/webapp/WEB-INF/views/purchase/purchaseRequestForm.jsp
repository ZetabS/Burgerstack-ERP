<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>발주 요청 페이지</title>
<style>
    .button-area{
        margin:5px;
    }
</style>
<!-- 레이아웃 작업 -->
<t:layout>

<layout:Page
    title="발주 요청"
    description="점포 자재를 선택하여 발주를 요청합니다.">

    

<form action="${pageContext.request.contextPath}/owner/purchases"
      method="post">
        <!-- 검색 / 필터 -->
        <layout:Section
            title="검색 조건"
            description="자재 유형 및 자재명을 기준으로 조회합니다.">

            <div class="d-flex justify-content-end align-items-center">

                <select id="typeFilter"
                        class="form-control mr-2"
                        style="width:160px;">

                    <option hidden selected disabled>
                        자재 유형
                    </option>

                    <option value="">전체</option>
                    <option value="상온">상온</option>
                    <option value="냉장">냉장</option>
                    <option value="냉동">냉동</option>
                    <option value="건자재">건자재</option>
                    <option value="주방용품">주방용품</option>
                    <option value="기타">기타</option>

                </select>

                <input type="text"
                    id="keyword"
                    class="form-control"
                    style="width:250px;"
                    placeholder="자재명 검색">

                <button type="button"
                        class="btn btn-secondary ml-2"
                        onclick="resetFilter()">
                    필터 초기화
                </button>
            </div>

        </layout:Section>

        <layout:TableSection
            title="발주 가능 자재"
            description="체크 후 수량을 입력하면 발주 목록에 추가됩니다.">
            <table class="table2 main-table">
                <thead>
                    <tr>
                        <th>
                            <div class="check-all" onclick="toggleCheckSaftyQty()">선택</div>
                        </th>
                        <th>자재 유형</th>
                        <th>자재명</th>
                        <th>공급가</th>
                        <th>재고 수량</th>
                        <th>안전재고 수량</th>
                        <th>요청 수량</th>
                        <th>자재별 금액</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="m" items="${list}">
                        <tr class="item-row ${m.status eq 'ACTIVE' ? '' : 'disabled-row'}" data-id="${m.materialId}">
                            <td>
                                <input type="checkbox" class="row-check">
                            </td>
                            <td class="item-type">
                                <c:choose>
                                    <c:when test="${m.materialType eq 'AF'}">상온</c:when>
                                    <c:when test="${m.materialType eq 'RF'}">냉장</c:when>
                                    <c:when test="${m.materialType eq 'FF'}">냉동</c:when>
                                    <c:when test="${m.materialType eq 'PK'}">건자재</c:when>
                                    <c:when test="${m.materialType eq 'KW'}">주방용품</c:when>
                                    <c:when test="${m.materialType eq 'ET'}">기타</c:when>
                                    <c:otherwise>${m.materialType}</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="item-name">${m.materialName}</td>
                            <td class="unit-price comma-number" data-price="${m.supplyPrice}">
                                ${m.supplyPrice}
                            </td>
                            <td class="stock">${m.currentQuantity}</td>
                            <td class="safety-stock">${m.safetyQuantity}</td>
                            <td>
                                <input type="number" class="qty-input" value="0" min="0" max="1000">
                            </td>
                            <td class="total-price">0</td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="2">총 금액</td>
                        <td colspan="5"></td>
                        <td>
                            <h3 class="main-total-amount">0원 </h3>
                        </td>
                    </tr>
                </tbody>
            </table>
        </layout:TableSection>
        <input type="hidden" name="itemsJson" id="itemsJson">

        <common:Actions>

            <div class="button-area">
                <button type="button"
                        class="btn btn-secondary"
                        onclick="location.href='${pageContext.request.contextPath}/owner/purchases'">

                    목록

                </button>
            </div>
            <div class="button-area">
                <button type="button"
                        class="btn btn-primary"
                        onclick="openSidebar()">

                    결제

                </button>
            </div>
        </common:Actions>


        <!-- 사이드 바 -->
        <t:sidebar>
            <jsp:attribute name="sidebarTitle">
                주문리스트
            </jsp:attribute>
            <jsp:body>
                <div class="sidebar-table-wrapper">
                    <table class="table2" id="sidebar-order-list">
                        <thead>
                            <tr>
                                <th>
                                    <div class="check-all" onclick="toggleCheckSaftyQty()">선택</div>
                                </th>
                                <th>품목</th>
                                <th>주문수량</th>
                                <th>구매가격</th>
                            </tr>
                        </thead>

                        <tbody>

                        </tbody>
                        <tfoot>
                            <tr>
                                <td><b>총 금액</b></td>
                                <td colspan="3">
                                    <h3 id="sidebar-total-amount">0원</h3>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <div style="margin-top:10px;">                    

                    <div style="width:90%; margin-left:20px;">
                        <textarea
                            name="orderMemo"
                            id="orderMemo"
                            rows="4"
                            style="width:100%; resize:none;"
                            placeholder="발주 관련 요청사항을 입력하세요."></textarea>
                        <br>
                        <button type="button"
                                class="button-primary"
                                onclick="submitOrder()"
                                style="width:90%; align-items:center; justify-content:center; display:flex;">
                            결제
                        </button>
                    </div>
                </div>
            </jsp:body>
        </t:sidebar>

    </form>

</layout:Page>
</t:layout>


<script>
    $(document).ready(function () {

        $('#typeFilter').on('change', function() {
            filterMaterials();
        });

        $('#keyword').on('input', function() {
            filterMaterials();
        });

        // =========================
        // 1. 수량 변경
        // =========================
        $('.qty-input').on('input', function () {

            let $row = $(this).closest('.item-row');

            let qty = parseInt($(this).val()) || 0;
            if (qty < 0) qty = 0;

            let price = Number($row.find('.unit-price').data('price')) || 0;

            let total = qty * price;

            $row.find('.total-price').text(total.toLocaleString());

            // 체크 자동
            $row.find('.row-check').prop('checked', qty > 0);
            
            updateSidebar();
        });


        // =========================
        // 2. 체크박스 변경
        // =========================
        $('.row-check').on('change', function () {
            // 체크박스가 변경된 행 찾기
            let $row = $(this).closest('.item-row');
            let $qty = $row.find('.qty-input');

            // 체크 시 안전재고 수량으로 변경, 해제 시 0으로 변경
            if ($(this).is(':checked')) {

                let safety =
                    parseInt($row.find('.safety-stock').text()) || 0;

                let current =
                    parseInt($row.find('.stock').text()) || 0;

                let qty = safety - current;

                // 안전재고보다 현재 재고가 많으면 수량 1로 설정
                if(qty <= 0){
                    qty = 1;
                }else if(qty > 1000){
                    qty = 1000;
                }
                // 체크 시 안전재고 수량으로 변경
                $qty.val(qty);

            } else {
                // 체크 해제 시 수량 0으로 변경
                $qty.val(0);
            }
            let price = Number($row.find('.unit-price').data('price')) || 0;
            let qty = parseInt($qty.val()) || 0;

            $row.find('.total-price').text((price * qty).toLocaleString());

            updateSidebar();
        });


        // =========================
        // 3. 사이드바 업데이트
        // =========================
        function updateSidebar() {

            let $tbody = $('#sidebar-order-list tbody');
            $tbody.empty();

            let total = 0;

            $('.main-table .item-row').each(function () {

                let $row = $(this);

                let checked = $row.find('.row-check').is(':checked');
                let qty = parseInt($row.find('.qty-input').val()) || 0;

                if (!checked || qty <= 0) return;

                let name = $row.find('.item-name').text().trim();
                let price = Number($row.find('.unit-price').data('price')) || 0;

                total += price * qty;

                // console.log("name = " + name);
                // console.log("price = " + price);
                // console.log("qty = " + qty);

                $('.item-row').each(function () {

                    let $row = $(this);

                    console.log("현재 row =", $row);

                    console.log(
                        "item-name count =",
                        $row.find('.item-name').length
                    );

                    console.log(
                        "qty-input count =",
                        $row.find('.qty-input').length
                    );

                });

                // 사이드바 출력
                $tbody.append(
                    $('<tr>').addClass('sidebar-row')
                    .attr('data-id', $row.data('id'))
                    .append(
                        $('<td>').html('<input type="checkbox" class="sidebar-check" checked>')
                    )
                    .append(
                        $('<td>').text(name)
                    )
                    .append(
                        $('<td>').append(
                            $('<input>')
                                .attr({
                                    type: 'number',
                                    min: 1,
                                    max: 1000
                                })
                                .addClass('sidebar-qty')
                                .val(qty)
                        )
                    )
                    .append(
                        $('<td>').text((price* qty).toLocaleString() + "원")
                    )
                );
        
            });

            $('.main-total-amount').text(total.toLocaleString() + "원");
            $('#sidebar-total-amount').text(total.toLocaleString() + "원");

            $('#totalAmountInput').val(total);

        }


        // =========================
        // 4. 사이드바 체크 이벤트
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

                    // 동기화 핵심
                    $row.find('.row-check').prop('checked', false);
                    $row.find('.qty-input').val(0);
                    $row.find('.total-price').text(0);
                }
            });

            updateSidebar();
        });

        // =========================
        // 5. 사이드바 수량 이벤트
        // =========================
        $(document).on('change', '.sidebar-qty', function () {

            let qty = parseInt($(this).val()) || 0;

            let materialId = $(this)
                .closest('tr')
                .data('id');

            let $mainRow = $('.item-row[data-id="' + materialId + '"]');

            $mainRow.find('.qty-input').val(qty);

            let price =
                Number($mainRow.find('.unit-price').data('price')) || 0;

            $mainRow.find('.total-price').text(price * qty);

            if (qty > 0) {
                $mainRow.find('.row-check').prop('checked', true);
            } else {
                $mainRow.find('.row-check').prop('checked', false);
            }

            updateSidebar();
        });

        priceFormatting();

    }); // 끝

function buildJson() {

    let items = [];

    $('.item-row').each(function () {

        let checked =
            $(this).find('.row-check').is(':checked');

        let qty =
            parseInt($(this).find('.qty-input').val()) || 0;

        if (!checked || qty <= 0) {
            return;
        }

        items.push({
            materialId: $(this).data('id'),
            materialNameSnapshot:
                $(this).find('.item-name').text().trim(),
            supplyPriceSnapshot:
                Number($(this).find('.unit-price').data('price')) || 0,
            requestQuantity: qty,
            orderMemo: $('#orderMemo').val()
        });
    });

    $('#itemsJson').val(JSON.stringify(items));

    return items;
}

// 주문 제출
function submitOrder() {

    let items = buildJson();

    if (items.length === 0) {
        alert("발주할 상품을 선택하세요.");
        return;
    }

    if (!confirm("발주를 진행하시겠습니까?")) {
        return;
    }

    document.forms[0].submit();
}

// 체크박스 안전재고 미달 선택/해제
let checked = true;

function toggleCheckSaftyQty() {

    checked = !checked;

        $('.item-row').each(function() {

        let $row = $(this);

        let stock =
            parseInt($row.find('.stock').text()) || 0;

        let safety =
            parseInt($row.find('.safety-stock').text()) || 0;

        let shortage = safety - stock;

        if(shortage > 0) {

            $row.find('.row-check')
                .prop('checked', checked)
                .trigger('change');

        } else if(!checked) {

            // 해제 시에는 전부 해제
            $row.find('.row-check')
                .prop('checked', false)
                .trigger('change');
        }
    });
}

// 수량 입력 제한
$('.qty-input').on('input', function () {

    let qty = parseInt($(this).val()) || 0;

    const MAX_QTY = 1000;

    if (qty > MAX_QTY) {
        alert('최대 주문 가능 수량은 ' + MAX_QTY + '개 입니다.');
        qty = MAX_QTY;
        $(this).val(MAX_QTY);
    }

    if (qty < 0) {
        qty = 0;
        $(this).val(0);
    }

});

// 엔터키로 인한 폼 제출 방지
$('form').on('keydown', function(e) {

    if(e.key === 'Enter') {
        e.preventDefault();
        return false;
    }

});

// 필터링 함수
$('#keyword').on('input', function() {
    filterMaterials();
});

function filterMaterials() {

    const selectedType =
        $('#typeFilter').val() || '';

    const keyword =
        $('#keyword')
            .val()
            .trim()
            .toLowerCase();

    $('.item-row').each(function() {

        const $row = $(this);

        const materialType =
            $row.find('.item-type')
                .text()
                .trim();

        const materialName =
            $row.find('.item-name')
                .text()
                .trim()
                .toLowerCase();

        const typeMatch =
            selectedType === '' ||
            materialType === selectedType;

        const keywordMatch =
            keyword === '' ||
            materialName.includes(keyword);

        if(typeMatch && keywordMatch) {
            $row.show();
        }
        else {
            $row.hide();
        }
    });
}
// 금액 포멧팅
function priceFormatting() {
    
    // 클래스가 'comma-number'인 모든 태그 선택
    const elements = document.querySelectorAll('.comma-number');
    
    elements.forEach(el => {
        const num = Number(el.textContent);
        // 숫자가 맞을 때만 변경
        if (!isNaN(num)) {
        el.textContent = num.toLocaleString('ko-KR');
        }
    });
}

$('#typeFilter').on('change', function() {
    filterMaterials();
});
$('#keyword').on('input', function() {
    filterMaterials();
});
$('#searchBtn').on('click', function() {
    filterMaterials();
});
function resetFilter() {

    $('#typeFilter').val('');
    $('#keyword').val('');

    filterMaterials();
}
</script>
