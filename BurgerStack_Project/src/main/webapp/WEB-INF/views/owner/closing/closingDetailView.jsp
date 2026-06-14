<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점주 마감 상세</title>

<style>
    .detail-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 35px 40px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .section-title {
        margin-bottom: 25px;
        padding-left: 12px;
        border-left: 5px solid #19c765;
        font-size: 22px;
        font-weight: bold;
    }

    .sub-title {
        margin-top: 35px;
        margin-bottom: 15px;
        font-size: 18px;
        font-weight: bold;
        color: #374151;
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

    .closing-item-table {
        width: 100%;
        table-layout: fixed;
    }

    .closing-item-table th,
    .closing-item-table td {
        text-align: center;
        vertical-align: middle;
    }

    .closing-item-table tbody tr:hover {
        background: #f8fafc;
    }

    .memo-text {
        white-space: normal;
    }

    .remain-qty {
        font-weight: bold;
        color: #2563eb;
    }

    .back-area {
        margin-top: 25px;
        text-align: center;
    }

    .back-btn {
        display: inline-block;
        padding: 10px 18px;
        background: #374151;
        color: #fff !important;
        text-decoration: none !important;
        border-radius: 8px;
        transition: 0.2s;
    }

    .back-btn:hover {
        background: #1f2937;
        color: #fff !important;
        text-decoration: none !important;
    }

    .empty-row {
        color: #888;
        padding: 28px 10px;
    }
</style>
</head>

<body>

<t:layout>

<section class="detail-card">

    <h2 class="section-title">점주 마감 상세</h2>

    <h3 class="sub-title">마감 정보</h3>

    <table class="info-table">
        <tr>
            <th>마감코드</th>
            <td>
                <c:choose>
                    <c:when test="${not empty closing.closingCode}">
                        ${closing.closingCode}
                    </c:when>
                    <c:otherwise>
                        C${closing.storeClosingId}
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>

        <tr>
            <th>영업일</th>
            <td>${closing.businessDate}</td>
        </tr>

        <tr>
            <th>비고</th>
            <td class="memo-text">
                <c:choose>
                    <c:when test="${empty closing.closingMemo}">
                        -
                    </c:when>
                    <c:otherwise>
                        ${closing.closingMemo}
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>

        <tr>
            <th>마감일시</th>
            <td>
                <c:choose>
                    <c:when test="${not empty closing.closedAt}">
                        ${closing.closedAt.toString().replace('T',' ').substring(0,19)}
                    </c:when>
                    <c:otherwise>
                        -
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>

    <h3 class="sub-title">마감 자재 목록</h3>

    <table class="closing-item-table">

        <colgroup>
            <col style="width:14%">
            <col style="width:18%">
            <col style="width:13%">
            <col style="width:13%">
            <col style="width:13%">
            <col style="width:17%">
            <col style="width:12%">
        </colgroup>

        <thead>
            <tr>
                <th>자재 유형</th>
                <th>자재명</th>
                <th>전산재고</th>
                <th>실사용수량</th>
                <th>폐기 수량</th>
                <th>폐기 사유</th>
                <th>잔여 수량</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="item" items="${itemList}">
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${item.materialType eq 'AF'}">상온</c:when>
                            <c:when test="${item.materialType eq 'RF'}">냉장</c:when>
                            <c:when test="${item.materialType eq 'FF'}">냉동</c:when>
                            <c:when test="${item.materialType eq 'PK'}">포장재</c:when>
                            <c:when test="${item.materialType eq 'KW'}">주방용품</c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${empty item.materialType}">
                                        -
                                    </c:when>
                                    <c:otherwise>
                                        ${item.materialType}
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${not empty item.materialName}">
                                ${item.materialName}
                            </c:when>
                            <c:otherwise>
                                ${item.materialNameSnapshot}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>${item.systemQuantity}</td>

                    <td>${item.physicalQuantity}</td>

                    <td>${item.disposalQuantity}</td>

                    <td>
                        <c:choose>
                            <c:when test="${empty item.closingItemMemo}">
                                -
                            </c:when>
                            <c:otherwise>
                                ${item.closingItemMemo}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <span class="remain-qty">
                            ${item.systemQuantity - item.physicalQuantity - item.disposalQuantity}
                        </span>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty itemList}">
                <tr>
                    <td colspan="7" class="empty-row">
                        마감 자재 내역이 없습니다.
                    </td>
                </tr>
            </c:if>
        </tbody>

    </table>

    <div class="back-area">
        <a class="back-btn"
           href="${pageContext.request.contextPath}/owner/closings">
            목록으로
        </a>
    </div>

</section>

</t:layout>

</body>
</html>