<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점포 상세 정보 조회</title>

<style>

.store-detail-wrap{
    width:1200px;
    margin:0 auto;
    padding-top:30px;
}

.page-title{
    font-size:32px;
    font-weight:bold;
    margin-bottom:30px;
}

.detail-card{
    background:white;
    border:1px solid #e5e7eb;
    border-radius:12px;
    padding:30px;
}

.detail-table{
    width:100%;
    border-collapse:collapse;
}

.detail-table th,
.detail-table td{
    border:1px solid #e5e7eb;
    padding:15px;
}

.detail-table th{
    width:200px;
    background:#f9fafb;
    text-align:left;
}

.btn-area{
    margin-top:30px;
    text-align:center;
}

.btn-area button{
    width:120px;
    height:40px;
    border:none;
    border-radius:6px;
    background:#19c765;
    color:white;
    cursor:pointer;
    font-weight:bold;
}

</style>

</head>
<body>

<t:menubarBO>

    <div class="store-detail-wrap">

        <h1 class="page-title">점포 상세 정보 조회</h1>

        <div class="detail-card">

            <table class="detail-table">

                <tr>
                    <th>점포 번호</th>
                    <td>${store.storeId}</td>
                </tr>

                <tr>
                    <th>점포 코드</th>
                    <td>${store.storeCode}</td>
                </tr>

                <tr>
                    <th>점포명</th>
                    <td>${store.storeName}</td>
                </tr>

                <tr>
                    <th>연락처</th>
                    <td>${store.phone}</td>
                </tr>

                <tr>
                    <th>주소</th>
                    <td>${store.address}</td>
                </tr>

                <tr>
                    <th>점주 번호</th>
                    <td>${store.ownerUserNo}</td>
                </tr>

                <tr>
                    <th>상태</th>
                    <td>${store.status}</td>
                </tr>

            </table>

            <button type="button"
			        onclick="location.href='${pageContext.request.contextPath}/owner/store'">
			    뒤로가기
			</button>

        </div>

    </div>

</t:menubarBO>

</body>
</html>