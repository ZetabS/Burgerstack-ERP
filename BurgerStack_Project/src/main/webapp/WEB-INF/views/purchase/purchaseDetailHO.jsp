<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>목록상세보기</title>
<style>
    table.table2 tbody tr:hover {
        background-color: #f5f5f5;
    }
    .content-top{
        display: flex;
    }
    .top-info {
        text-align: left;
        width: 200px;
    }
    .top-info div{
        padding: 5px;
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
</style>

<!-- 레이아웃 작업 -->
<t:layout>
<div class="outer">
    <h2>발주 상세 보기(관리자)</h2>

    <table class="info-table">
        <tr>
            <th>발주코드</th>
            <td>${list[0].purchaseCode}</td>
            <th>상태</th>
            <td>
                <c:choose>
                    <c:when test="${list[0].status eq 'REQUESTED'}">
                        <h6><span class="badge bg-secondary">요청중</span></h6>
                    </c:when>
                    <c:when test="${list[0].status eq 'PARTIALLY_APPROVED'}">
                        <h6><span class="badge bg-success">부분승인</span></h6>
                    </c:when>
                    <c:when test="${list[0].status eq 'APPROVED'}">
                        <h6><span class="badge bg-success">승인</span></h6>
                    </c:when>
                    <c:when test="${list[0].status eq 'CANCELED'}">
                        <h6><span class="badge bg-danger">발주취소</span></h6>
                    </c:when>
                    <c:when test="${list[0].status eq 'REJECTED'}">
                        <h6><span class="badge bg-danger">반려</span></h6>
                    </c:when>
                    <c:when test="${list[0].status eq 'RECEIVED'}">
                        <h6><span class="badge bg-info">입고완료</span></h6>
                    </c:when>
                    <c:otherwise>
                        <h6><span class="badge bg-warning">배송중</span></h6>
                    </c:otherwise>
                </c:choose>
            </td>

        </tr>
        <tr>
            <th>점포명</th>
            <td>${list[0].storeName}</td>
            <th>요청자</th>
            <td>
                ${list[0].userName}
                (${list[0].role eq 'OWNER' ? '점주' : (list[0].role eq 'ADMIN' ? '관리자' : list[0].role)})
            </td>
        </tr>
        <tr>
            <th>요청일시</th>
            <td colspan="3">${list[0].createdAt.toString().replace('T', ' ')}</td>
        </tr>
        <tr>
            <th>비고</th>
            <td colspan="3">${list[0].orderMemo}</td>    
        </tr>
    </table>

    <br>

    <h3>요청 품목</h3>


    <table class="table2">
        <thead>
            <tr>
                <th>자재 코드</th>
                <th>자재 유형</th>
                <th>자재명</th>
                <th>재고 수량</th>

                <th>요청 수량</th>

                <c:if test="${list[0].status eq 'APPROVED'
                        || list[0].status eq 'PARTIALLY_APPROVED'
                        || list[0].status eq 'REJECTED'}">

                    <th>승인 수량</th>
                    <th>반려 수량</th>
                    <th>반려 사유</th>

                </c:if>

                <th>공급가</th>
                <th>자재별 금액</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="item" items="${list}">
                <tr class="item-row ${item.status eq 'REQUESTED' ? '' : 'disabled-row'}">
                    <td>${item.materialCode}</td>

                    <td class="item-type">
                        <c:choose>
                            <c:when test="${item.materialType eq 'AF'}">상온</c:when>
                            <c:when test="${item.materialType eq 'RF'}">냉장</c:when>
                            <c:when test="${item.materialType eq 'FF'}">냉동</c:when>
                            <c:when test="${item.materialType eq 'PK'}">건자재</c:when>
                            <c:when test="${item.materialType eq 'KW'}">주방용품</c:when>
                            <c:when test="${item.materialType eq 'ET'}">기타</c:when>
                            <c:otherwise>${item.materialType}</c:otherwise>
                        </c:choose>
                    </td>

                    <td>${item.materialName}</td>

                    <td>${item.currentQuantity}</td>

                    <!-- 요청수량 -->
                    <td>${item.requestQuantity}</td>

                    <c:if test="${list[0].status eq 'APPROVED'
                            || list[0].status eq 'PARTIALLY_APPROVED'
                            || list[0].status eq 'REJECTED'}">

                        <!-- 승인수량 -->
                        <td>
                            ${item.approvedQuantity}
                        </td>

                        <!-- 반려수량 -->
                        <td>
                            ${item.requestQuantity - item.approvedQuantity}
                        </td>

                        <!-- 반려사유 -->
                        <td>
                            <c:choose>

                                <c:when test="${empty item.rejectReason}">
                                    -
                                </c:when>

                                <c:otherwise>
                                    ${item.rejectReason}
                                </c:otherwise>

                            </c:choose>
                        </td>

                    </c:if>

                    <td class="comma-number">${item.supplyPriceSnapshot}</td>

                    <td class="comma-number">
                        <c:set var="rowTotal" value="${item.requestQuantity * item.supplyPriceSnapshot}" />
                        ${rowTotal}
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br><br>

    <div class="bottom-area" >
        <div class="total-price-area">
            <div>총 결제금액</div>
            <c:set var="total" value="0"/>
            <c:forEach var="item" items="${list}">
                <c:set var="total" value="${total + item.totalPrice}"/>
            </c:forEach>
            <h2><span class="comma-number">${total}</span> 원</h2>
        </div>

        <div class="button-group" style="display:flex; gap:10px; align-items:center;">
            <button type="button" class="button-secondary" onclick="location.href = '${pageContext.request.contextPath}/admin/purchases'"> 목록 </button>
            <c:choose>
                <c:when test="${list[0].status eq 'REQUESTED'}">
                    <button class="button-primary" onclick="location.href='${pageContext.request.contextPath}/admin/purchases/${list[0].purchaseOrderId}/approve'">
                        발주 결재
                    </button>
                </c:when>
                <c:when test="${list[0].status eq 'PARTIALLY_APPROVED' || list[0].status eq 'APPROVED'}">
                    <button class="button-secondary" disabled>결재 처리됨</button>
                    <form action="${pageContext.request.contextPath}/admin/purchases/${list[0].purchaseOrderId}/cancel" method="post">
                        <button class="button-danger" type="submit"
                                onclick="return confirm('발주를 취소하시겠습니까?')">
                            결재 취소
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <!-- 동작 없음 -->
                </c:otherwise>
            </c:choose>
        </div>
    </div>
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