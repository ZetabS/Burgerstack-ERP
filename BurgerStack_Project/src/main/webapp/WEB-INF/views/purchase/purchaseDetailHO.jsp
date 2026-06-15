<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>목록상세보기</title>
<style>
    .button-area{
        margin:5px;
    }
</style>
<!-- 레이아웃 작업 -->
<t:layout>

<layout:Page
    title="발주 상세 보기"
    description="발주 상세 정보를 조회합니다.">

    <jsp:body>

        <layout:Section
            title="발주 정보"
            description="발주 기본 정보를 조회합니다.">

            <common:FieldList>

                <layout:FieldRow label="발주코드">
                    ${list[0].purchaseCode}
                </layout:FieldRow>

                <layout:FieldRow label="상태">

                    <display:PurchaseStatusBadge
                        value="${list[0].status}" />

                </layout:FieldRow>

                <layout:FieldRow label="점포명">
                    ${list[0].storeName}
                </layout:FieldRow>

                <layout:FieldRow label="요청자">
                    ${list[0].userName}
                    (${list[0].role eq 'OWNER'
                        ? '점주'
                        : (list[0].role eq 'ADMIN'
                            ? '관리자'
                            : list[0].role)})
                </layout:FieldRow>

                <layout:FieldRow label="요청일시">
                    ${list[0].createdAt.toString().replace('T',' ')}
                </layout:FieldRow>

                <layout:FieldRow label="비고">
                    ${empty list[0].orderMemo ? '-' : list[0].orderMemo}
                </layout:FieldRow>

            </common:FieldList>

        </layout:Section>

        <br>

        <layout:TableSection
            title="요청 품목"
            description="발주된 자재 목록입니다.">
                <table:Table
                isEmpty="${empty list}"
                emptyMessage="조회된 품목이 없습니다.">

                <jsp:attribute name="thead">

                    <tr>
                        <th>자재코드</th>
                        <th>자재유형</th>
                        <th>자재명</th>
                        <th>재고수량</th>
                        <th>요청수량</th>

                        <c:if test="${list[0].status eq 'APPROVED'
                                || list[0].status eq 'PARTIALLY_APPROVED'
                                || list[0].status eq 'REJECTED'}">

                            <th>승인수량</th>
                            <th>반려수량</th>
                            <th>반려사유</th>

                        </c:if>

                        <th>공급가</th>
                        <th>자재별 금액</th>

                    </tr>

                </jsp:attribute>

                <jsp:attribute name="tbody">

                    <c:forEach var="item" items="${list}">

                        <table:TableRow>

                            <table:TextFitCell
                                value="${item.materialCode}" />

                            <table:FitCell>

                                <display:MaterialTypeLabel
                                    value="${item.materialType}" />

                            </table:FitCell>

                            <table:TextCell
                                value="${item.materialName}" />

                            <table:NumberCell
                                value="${item.currentQuantity}" />

                            <table:NumberCell
                                value="${item.requestQuantity}" />

                            <c:if test="${list[0].status eq 'APPROVED'
                                    || list[0].status eq 'PARTIALLY_APPROVED'
                                    || list[0].status eq 'REJECTED'}">

                                <table:NumberCell
                                    value="${item.approvedQuantity}" />

                                <table:NumberCell
                                    value="${item.requestQuantity - item.approvedQuantity}" />

                                <table:TextCell
                                    value="${empty item.rejectReason ? '-' : item.rejectReason}" />

                            </c:if>

                            <table:MoneyCell
                                value="${item.supplyPriceSnapshot}"
                                suffix="원" />

                            <table:MoneyCell
                                value="${item.requestQuantity * item.supplyPriceSnapshot}"
                                suffix="원" />

                        </table:TableRow>

                    </c:forEach>

                </jsp:attribute>

                

            </table:Table>

        </layout:TableSection>

        <layout:Section
            title="결제 정보">

            <c:set var="total" value="0"/>

            <c:forEach var="item" items="${list}">
                <c:set var="total"
                    value="${total + item.totalPrice}"/>
            </c:forEach>

            
            <h3>
                총 결제금액 :
                <fmt:formatNumber value="${total}" pattern="#,###"/>원
            </h3>

        </layout:Section>

        <common:Actions>

            <div class="button-area">

                <button type="button"
                        class="btn btn-secondary"
                        onclick="location.href='${pageContext.request.contextPath}/admin/purchases'">
                    목록
                </button>
            </div>
            <div class="button-area">
                <c:choose>

                    <c:when test="${list[0].status eq 'REQUESTED'}">

                        <button type="button"
                                class="btn btn-primary"
                                onclick="location.href='${pageContext.request.contextPath}/admin/purchases/${list[0].purchaseOrderId}/approve'">
                            발주 결재
                        </button>

                    </c:when>

                    <c:when test="${list[0].status eq 'PARTIALLY_APPROVED'
                                || list[0].status eq 'APPROVED'}">

                        <form action="${pageContext.request.contextPath}/admin/purchases/${list[0].purchaseOrderId}/cancel"
                            method="post">

                            <button class="btn btn-danger"
                                    type="submit"
                                    onclick="return confirm('발주를 취소하시겠습니까?')">

                                결재 취소

                            </button>

                        </form>

                    </c:when>

                </c:choose>
            </div>
        </common:Actions>

    </jsp:body>

</layout:Page>

</t:layout>
<script>
    // 금액 포멧팅
    // 클래스가 'comma-number'인 모든 태그 선택
    const elements = document.querySelectorAll('.comma-number');
    
    elements.forEach(el => {
        const num = Number(el.textContent);
        // 숫자가 맞을 때만 변경
        if (!isNaN(num)) {
        el.textContent = num.toLocaleString('ko-KR');
        }
    });
</script>