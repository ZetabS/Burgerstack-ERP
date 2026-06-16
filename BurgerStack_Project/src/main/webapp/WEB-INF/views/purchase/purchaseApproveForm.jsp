<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>
<title>발주 상태 처리</title>
<style>
    table input{
        width: 50px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
    }
    th {
        background: #19c765;
        color: white;
        padding: 14px;
        text-align: center;
        font-weight: bold;
    }
    td {
        padding: 14px;
        border-bottom: 1px solid #e5e7eb;
        text-align: center;
    }
    .info-table th {
        width: 180px;
    }

    .info-table td {
        text-align: left;
        padding-left: 20px;
    }
    td h6 {
        margin: 0;
    }
    h6 .badge {
        font-size: 0.8em;
        padding: 0.25em 0.4em;
        margin: 0;
    }
    .bg-secondary {
        color: #ffffff !important;
    }
    .bg-success {
        color: #ffffff !important;
    }
    .bg-danger {
        color: #ffffff !important;
    }
    .bg-info {
        color: #ffffff !important;
    }
    .bg-warning {
        color: #ffffff !important;
    }

    /* 모달창 css */
    .modal-overlay {

        display:none;

        position:fixed;

        top:0;
        left:0;

        width:100%;
        height:100%;

        background:rgba(0,0,0,0.4);

        justify-content:center;
        align-items:center;

        z-index:9999;
    }

    .modal-box {

        width:500px;

        background:white;

        border-radius:8px;

        padding:25px;
    }

    .summary-table {

        width:100%;
    }

    .summary-table th {

        width:120px;
    }

    .modal-actions {

        display:flex;

        justify-content:flex-end;

        gap:10px;
    }
</style>

<!-- 레이아웃 작업 -->
<t:layout>

<layout:Page
    title="발주 상태 처리"
    description="발주 요청 품목의 승인/반려를 처리합니다.">

    <jsp:attribute name="actions">
        <common:ReturnLink href="javascript:history.back()">
            이전으로
        </common:ReturnLink>
    </jsp:attribute>

    <jsp:body>

        <form method="post">

            <!-- 발주 기본 정보 -->
            <layout:Section
                title="발주 정보"
                description="요청된 발주의 기본 정보를 확인합니다.">

                <common:FieldList>

                    <layout:FieldRow label="발주번호">
                        ${list[0].purchaseCode}
                    </layout:FieldRow>

                    <layout:FieldRow label="점포명">
                        ${list[0].storeName}
                    </layout:FieldRow>

                    <layout:FieldRow label="상태">
                        <display:PurchaseStatusBadge
                            value="${list[0].status}" />
                    </layout:FieldRow>

                    <layout:FieldRow label="비고">
                        ${list[0].orderMemo}
                    </layout:FieldRow>

                </common:FieldList>

            </layout:Section>


            <!-- 결재 품목 -->
            <layout:Section
                title="결재 품목"
                description="품목별 승인수량 및 반려사유를 입력합니다.">

                <table class="table">

                    <thead>
                        <tr>
                            <th>자재코드</th>
                            <th>자재유형</th>
                            <th>자재명</th>
                            <th>요청수량</th>
                            <th>승인수량</th>
                            <th>반려수량</th>
                            <th>반려사유</th>
                            <th>공급가</th>
                            <th>금액</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach var="item"
                                   items="${list}"
                                   varStatus="s">

                            <input type="hidden"
                                   name="items[${s.index}].materialId"
                                   value="${item.materialId}"/>

                            <input type="hidden"
                                   name="items[${s.index}].requestQuantity"
                                   value="${item.requestQuantity}"/>

                            <tr>

                                <td>${item.materialCode}</td>

                                <td>
                                    <display:MaterialTypeLabel
                                        value="${item.materialType}" />
                                </td>

                                <td>${item.materialName}</td>

                                <td class="requestQty">
                                    ${item.requestQuantity}
                                </td>

                                <td>
                                    <input type="number"
                                           class="approvedQty form-control"
                                           name="items[${s.index}].approvedQuantity"
                                           value="${item.requestQuantity}"
                                           min="0">
                                </td>

                                <td>
                                    <input type="number"
                                           class="rejectQty form-control"
                                           name="items[${s.index}].rejectQuantity"
                                           value="0"
                                           min="0"
                                           readonly>
                                </td>

                                <td>
                                    <select
                                        class="reason form-control"
                                        name="items[${s.index}].rejectReason"
                                        disabled>

                                        <option value="">선택</option>
                                        <option value="재고부족">재고부족</option>
                                        <option value="품절">품절</option>
                                        <option value="공급중단">공급중단</option>

                                    </select>
                                </td>

                                <td class="comma-number">
                                    ${item.supplyPriceSnapshot}
                                </td>

                                <td class="itemPrice"
                                    data-unit-price="${item.supplyPriceSnapshot}">
                                    ${item.totalPrice}
                                </td>

                            </tr>

                        </c:forEach>

                    </tbody>

                    <tfoot>
                        <tr>
                            <th>
                                총 금액
                            </th>
                            <td colspan="7"></td>
                            <td id="totalAmount">
                                0원
                            </td>
                        </tr>
                    </tfoot>

                </table>

            </layout:Section>


            <common:Actions>
                <div class="action-area">
                    <button type="button"
                            class="btn btn-danger"
                            id="rejectBtn">
                        전체 반려
                    </button>

                    <button type="submit"
                            class="btn btn-primary"
                            id="confirmBtn">
                        결재
                    </button>

                    <button type="button"
                            class="btn btn-secondary"
                            onclick="history.back()">
                        이전으로
                    </button>
                </div>
            </common:Actions>

            <!-- 모달창 -->
            <div id="rejectModal" class="modal-overlay">

                <div class="modal-box">

                    <h3>발주 반려</h3>

                    <table class="summary-table">

                        <tr>
                            <th>발주번호</th>
                            <td>${list[0].purchaseCode}</td>
                        </tr>

                        <tr>
                            <th>품목 수</th>
                            <td>${list.size()}건</td>
                        </tr>

                        <tr>
                            <th>총 금액</th>
                            <td id="modalTotalAmount"></td>
                        </tr>

                    </table>

                    <br>

                    <label>
                        반려 사유
                    </label>

                    <textarea
                        id="rejectMemo"
                        rows="4"
                        maxlength="500"
                        placeholder="반려 사유를 입력하세요."
                        style="width:100%; resize: none;"></textarea>

                    <br><br>

                    <div class="modal-actions">

                        <button
                            type="button"
                            class="btn btn-secondary"
                            id="closeRejectModal">
                            취소
                        </button>

                        <button
                            type="button"
                            class="btn btn-danger"
                            id="submitReject">
                            반려 확정
                        </button>

                    </div>

                </div>

            </div>

            <!-- 모달 정보 넘기기 -->
            <input type="hidden"
                id="isBulkReject"
                name="isBulkReject"
                value="N">

            <input type="hidden"
                id="bulkRejectReason"
                name="bulkRejectReason">

        </form>

    </jsp:body>

</layout:Page>

</t:layout>

<script>
    // 페이지 로드 시 실행
    $(initPage);

    function initPage(){

        formatPrices();

        $('.rejectQty').each(function(){

            const row = $(this).closest('tr');

            toggleReason(row);
            updateAmount(row);

        });
    }

    function formatPrices(){

        $('.comma-number').each(function(){

            const num = Number($(this).text());

            if(!isNaN(num)){

                $(this).text(
                    num.toLocaleString('ko-KR')
                );
            }
        });
    }

    // =================================
    // 공통 함수
    // =================================
    function syncQuantities(row, approvedQty){

        const requestQty =
            Number(row.find('.requestQty').text()) || 0;

        approvedQty =
            Math.max(0,
            Math.min(approvedQty, requestQty));

        const rejectQty =
            requestQty - approvedQty;

        row.find('.approvedQty').val(approvedQty);

        row.find('.rejectQty').val(rejectQty);

        toggleReason(row);
        updateAmount(row);
    }

    // =================================
    // 승인수량 변경
    // =================================
    $(document).on(
        'input',
        '.approvedQty',
        function(){

            const row =
                $(this).closest('tr');

            syncQuantities(
                row,
                Number($(this).val())
            );
        }
    );


    // =================================
    // 반려수량 변경
    // =================================
    $(document).on(
        'input',
        '.rejectQty',
        function(){

            const row =
                $(this).closest('tr');

            const requestQty =
                Number(
                    row.find('.requestQty').text()
                ) || 0;

            const rejectQty =
                Number($(this).val()) || 0;

            syncQuantities(
                row,
                requestQty - rejectQty
            );
        }
    );


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
    function validateRejectReason(){

        // 전체 반려는 개별 반려사유 검사 안함
        if($('#isBulkReject').val() === 'Y'){
            return true;
        }

        let valid = true;

        $('.rejectQty').each(function(){

            const row =
                $(this).closest('tr');

            const rejectQty =
                Number($(this).val()) || 0;

            const reason =
                row.find('.reason').val();

            if(rejectQty > 0 && !reason){

                row.find('.reason').focus();

                valid = false;

                return false;
            }
        });

        return valid;
    }

    // 모달창 열기
    $('#rejectBtn').on('click', function(){

        $('#modalTotalAmount').text(
            $('#totalAmount').text()
        );

        $('#rejectModal').css('display', 'flex');

    });

    // 모달창 닫기
    $('#closeRejectModal').on('click', function(){

        $('#rejectModal').hide();

    });

    // 반려 확정
    $('#submitReject').on('click', function(){

        const reason =
            $('#rejectMemo').val().trim();

        if(!reason){

            alert('반려 사유를 입력해주세요.');
            return;
        }

        if(!confirm('해당 발주를 전체 반려하시겠습니까?')){
            return;
        }

        applyBulkReject(reason);

        $('form').submit();
    });

    $('#rejectBtn').on('click', openRejectModal);

    $('#closeRejectModal').on(
        'click',
        closeRejectModal
    );

    function validateRejectReason(){

        let valid = true;

        $('.rejectQty').each(function(){

            const row =
                $(this).closest('tr');

            const rejectQty =
                Number($(this).val()) || 0;

            const reason =
                row.find('.reason').val();

            if(rejectQty > 0 && !reason){

                row.find('.reason').focus();

                valid = false;

                return false;
            }
        });

        return valid;
    }

    function applyBulkReject(reason){

        $('.approvedQty').each(function(){

            const row = $(this).closest('tr');

            const requestQty =
                Number(
                    row.find('.requestQty').text()
                ) || 0;

            // 승인수량 0
            row.find('.approvedQty').val(0);

            // 반려수량 = 요청수량
            row.find('.rejectQty')
                .prop('disabled', false)
                .val(requestQty);

            // 검증 통과용 임시값
            row.find('.reason')
                .prop('disabled', false)
                .append(
                    '<option value="BULK_REJECT" selected>전체반려</option>'
                )
                .val('BULK_REJECT');

            const reason = $('#rejectMemo').val().trim();

            row.find('.reason')
                .prop('disabled', false)
                .append(
                    '<option value="' + reason + '" selected>'
                    + reason +
                    '</option>'
                )
                .val(reason);
        });

        $('#isBulkReject').val('Y');
        $('#bulkRejectReason').val(reason);
    }

    $('form').on('submit', function(e){

        $('.reason').each(function(){
            console.log($(this).val());
        });

        if(!validateRejectReason()){

            alert(
                '반려수량이 있는 경우 반려사유를 선택해야 합니다.'
            );

            e.preventDefault();
            return;
        }

        // 전체 반려인 경우 confirm 생략
        if($('#isBulkReject').val() === 'Y'){
            return;
        }

        if(
            !confirm(
                '발주를 결재하시겠습니까?\n\n결재 후에는 처리 상태가 변경됩니다.'
            )
        ){
            e.preventDefault();
        }
    });
</script>
