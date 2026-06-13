<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
    .page-title {
        font-size: 30px;
        font-weight: 700;
        margin-bottom: 28px;
    }

    .info-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 24px 28px;
        margin-bottom: 24px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.04);
    }

    .info-grid {
        display: grid;
        grid-template-columns: 160px 1fr 160px 1fr;
        row-gap: 16px;
        column-gap: 14px;
        align-items: center;
    }

    .info-label {
        color: #6b7280;
        font-weight: 700;
        font-size: 14px;
    }

    .info-value {
        color: #111827;
        font-size: 15px;
    }

    .info-value a {
        color: #ff6b00;
        font-weight: 700;
        text-decoration: none;
    }

    .info-value a:hover {
        text-decoration: underline;
    }

    .status-badge {
        display: inline-block;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: 700;
    }

    .status-normal {
        background: #dcfce7;
        color: #166534;
    }

    .status-diff {
        background: #ffedd5;
        color: #c2410c;
    }

    .table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
        margin-top: 0;
        background: #fff;
    }

    .table thead th {
        background: #f8fafc;
        color: #374151;
        font-weight: 700;
        border-top: 1px solid #e5e7eb;
        border-bottom: 2px solid #d1d5db;
        padding: 14px 12px;
        text-align: center;
    }

    .table tbody td,
    .table tbody th {
        border-bottom: 1px solid #e5e7eb;
        padding: 14px 12px;
        vertical-align: middle;
        text-align: center;
    }

    .table tbody tr:hover {
        background: #fff7ed;
    }

    .text-right {
        text-align: right !important;
    }

    .text-left {
        text-align: left !important;
    }

    .total-row th,
    .total-row td {
        background: #f9fafb;
        font-weight: 700;
    }

    .total-price {
        color: #ff6b00;
        font-size: 17px;
        font-weight: 700;
    }

    .memo-box {
        margin-top: 22px;
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 18px 24px;
        text-align: left;
    }

    .memo-title {
        margin-bottom: 10px;
        color: #374151;
        font-weight: 700;
        font-size: 15px;
    }

    .memo-content {
        min-height: 36px;
        color: #4b5563;
        line-height: 1.6;
        white-space: normal;
        text-align: left;
        display: block;
    }

    .btn-area {
        margin-top: 24px;
        text-align: center;
    }

    .list-btn {
        display: inline-block;
        padding: 9px 18px;
        background: #374151;
        color: #fff !important;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none !important;
    }

    .list-btn:hover {
        background: #1f2937;
        color: #fff !important;
        text-decoration: none !important;
    }
</style>
</head>

<body>

<t:layout>

    <h2 class="page-title">입고 이력 상세</h2>

    <!-- 입고 기본 정보 -->
    <div class="info-card">
        <div class="info-grid">

            <div class="info-label">입고 코드</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${not empty receipt.receiptCode}">
                        ${receipt.receiptCode}
                    </c:when>
                    <c:otherwise>
                        R${receipt.receiptId}
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="info-label">발주 코드</div>
            <div class="info-value">
                <a href="${pageContext.request.contextPath}/admin/purchases/${receipt.purchaseOrderId}">
                    <c:choose>
                        <c:when test="${not empty receipt.purchaseCode}">
                            ${receipt.purchaseCode}
                        </c:when>
                        <c:otherwise>
                            P${receipt.purchaseOrderId}
                        </c:otherwise>
                    </c:choose>
                </a>
            </div>

            <div class="info-label">점포명</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${not empty receipt.storeName}">
                        ${receipt.storeName}
                    </c:when>
                    <c:otherwise>
                        -
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="info-label">입고 상태</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${receipt.receiptStatus eq 'DIFFERENCE'}">
                        <span class="status-badge status-diff">차이 있음</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge status-normal">정상 입고</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="info-label">입고 완료일시</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${not empty receipt.receivedAt}">
                        ${receipt.receivedAt.toString().replace('T',' ').substring(0,19)}
                    </c:when>
                    <c:otherwise>
                        -
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="info-label">승인 담당자</div>
            <div class="info-value">-</div>

        </div>
    </div>

    <!-- 상세 품목 테이블 -->
    <table class="table">
        <thead>
            <tr>
                <th>자재 코드</th>
                <th>자재명</th>
                <th>자재 유형</th>
                <th>단가</th>
                <th>승인 수량</th>
                <th>요청 수량</th>
                <th>실입고 수량</th>
                <th>차이 수량</th>
                <th>사유</th>
                <th>금액</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
                <c:when test="${empty itemList}">
                    <tr>
                        <td colspan="10" align="center">
                            입고 상세 내역이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:set var="totalPrice" value="0" />

                    <c:forEach var="item" items="${itemList}">
                        <tr>
                            <td>${item.materialCode}</td>
                            <td class="text-left">${item.materialName}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.materialType eq 'AF'}">상온</c:when>
                                    <c:when test="${item.materialType eq 'RF'}">냉장</c:when>
                                    <c:when test="${item.materialType eq 'FF'}">냉동</c:when>
                                    <c:when test="${item.materialType eq 'PK'}">포장재</c:when>
                                    <c:when test="${item.materialType eq 'KW'}">주방용품</c:when>
                                    <c:otherwise>${item.materialType}</c:otherwise>
                                </c:choose>
                            </td>

                            <td class="text-right">
                                <fmt:formatNumber value="${item.supplyPrice}" pattern="#,###" />원
                            </td>

                            <td>${item.approvedQuantity}</td>
                            <td>${item.requestQuantity}</td>
                            <td>${item.receivedQuantity}</td>
                            <td>${item.defectQuantity}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${empty item.receiptItemMemo}">
                                        -
                                    </c:when>
                                    <c:otherwise>
                                        ${item.receiptItemMemo}
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td class="text-right">
                                <fmt:formatNumber value="${item.amount}" pattern="#,###" />원
                            </td>
                        </tr>

                        <c:set var="totalPrice" value="${totalPrice + item.amount}" />
                    </c:forEach>

                    <tr class="total-row">
                        <th colspan="9" class="text-right">총 금액</th>
                        <td class="text-right">
                            <span class="total-price">
                                <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
                            </span>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- 비고 -->
    <div class="memo-box">
        <div class="memo-title">비고</div>
        <div class="memo-content"><c:choose><c:when test="${empty receipt.receiptMemo}">-</c:when><c:otherwise>${receipt.receiptMemo}</c:otherwise></c:choose></div>
    </div>

    <div class="btn-area">
        <a class="list-btn"
           href="${pageContext.request.contextPath}/admin/receipts">
            목록으로
        </a>
    </div>

</t:layout>

</body>
</html>