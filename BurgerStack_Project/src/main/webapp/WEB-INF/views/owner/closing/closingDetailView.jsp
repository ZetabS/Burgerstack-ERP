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

    .back-btn {
        display: inline-block;
        margin-top: 25px;
        padding: 10px 18px;
        background: #374151;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        transition: 0.2s;
    }

    .back-btn:hover {
        background: #1f2937;
    }
</style>
</head>

<body>

<t:menubarBO>

<section class="detail-card">

    <h2 class="section-title">점주 마감 상세</h2>

    <h3 class="sub-title">마감 정보</h3>

    <table class="info-table">
        <tr>
            <th>마감번호</th>
            <td>${closing.storeClosingId}</td>
        </tr>
        <tr>
            <th>영업일</th>
            <td>${closing.businessDate}</td>
        </tr>
        <tr>
            <th>마감메모</th>
            <td>${closing.closingMemo}</td>
        </tr>
        <tr>
            <th>마감일시</th>
            <td>${closing.closedAt}</td>
        </tr>
    </table>

    <h3 class="sub-title">마감 자재 목록</h3>

    <table class="closing-item-table">

        <colgroup>
            <col style="width:15%">
            <col style="width:15%">
            <col style="width:15%">
            <col style="width:15%">
            <col style="width:25%">
            <col style="width:15%">
        </colgroup>

        <thead>
            <tr>
                <th>자재명</th>
                <th>전산수량</th>
                <th>사용수량</th>
                <th>폐기수량</th>
                <th>폐기사유</th>
                <th>현재(남은) 수량</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="item" items="${itemList}">
                <tr>
                    <td>${item.materialNameSnapshot}</td>
                    <td>${item.systemQuantity}</td>
                    <td>${item.physicalQuantity}</td>
                    <td>${item.disposalQuantity}</td>
                    <td>${item.closingItemMemo}</td>
                    <td>${item.systemQuantity - item.physicalQuantity - item.disposalQuantity}</td>
                </tr>
            </c:forEach>
        </tbody>

    </table>

    <a class="back-btn"
       href="${pageContext.request.contextPath}/owner/closings">
        목록으로
    </a>

</section>

</t:menubarBO>

</body>
</html>