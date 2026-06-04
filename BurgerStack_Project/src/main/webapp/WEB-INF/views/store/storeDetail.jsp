<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점포 상세 정보 조회</title>

<style>
    .store-detail-wrap {
        width: 1300px;
        margin: 0 auto;
        padding-top: 35px;
    }

    .page-title {
        margin-bottom: 8px;
        font-size: 32px;
        font-weight: bold;
    }

    .page-desc {
        margin-bottom: 35px;
        color: #6b7280;
        font-size: 14px;
    }

    .form-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 35px 40px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }

    .section-title {
        margin-bottom: 25px;
        padding-left: 12px;
        border-left: 5px solid #19c765;
        font-size: 22px;
        font-weight: bold;
        color: #111827;
    }

    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 22px 35px;
    }

    .form-row {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .form-row.full {
        grid-column: 1 / 3;
    }

    .form-row label {
        font-size: 14px;
        font-weight: bold;
        color: #374151;
    }

    .form-row input,
    .form-row select {
        height: 42px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 0 12px;
        font-size: 14px;
    }

    .form-row input:focus,
    .form-row select:focus {
        outline: none;
        border-color: #19c765;
        box-shadow: 0 0 0 3px rgba(25, 199, 101, 0.12);
    }

    .btn-area {
        display: flex;
        justify-content: center;
        gap: 12px;
        margin-top: 35px;
        padding-top: 25px;
        border-top: 1px solid #e5e7eb;
    }

    .btn-area button {
        width: 120px;
        height: 42px;
        border-radius: 8px;
        border: none;
        font-weight: bold;
        cursor: pointer;
    }

    .btn-update {
        background: #19c765;
        color: white;
    }

    .btn-delete {
        background: #ef4444;
        color: white;
    }

    .btn-list {
        background: white;
        color: #374151;
        border: 1px solid #d1d5db !important;
    }

    .btn-update:hover {
        background: #13a856;
    }

    .btn-delete:hover {
        background: #dc2626;
    }

    .btn-list:hover {
        background: #f3f4f6;
    }
</style>
</head>

<body>

<t:menubarHO>

    <main class="store-detail-wrap">

        <h1 class="page-title">점포 상세 정보 조회</h1>
        <p class="page-desc">점포 정보를 확인하고 수정할 수 있습니다.</p>

        <form action="${pageContext.request.contextPath}/admin/stores/${store.storeId}" method="post">

            <input type="hidden" name="storeId" value="${store.storeId}">

            <section class="form-card">

                <h2 class="section-title">점포 정보</h2>

                <div class="form-grid">

                    <div class="form-row">
                        <label for="storeName">점포명</label>
                        <input type="text"
                               id="storeName"
                               name="storeName"
                               value="${store.storeName}">
                    </div>

                    <div class="form-row">
                        <label for="status">상태</label>
                        <select id="status" name="status">
                            <option value="OPEN" ${store.status eq 'OPEN' ? 'selected' : ''}>영업중</option>
                            <option value="CLOSED" ${store.status eq 'CLOSED' ? 'selected' : ''}>폐점</option>
                        </select>
                    </div>

                    <div class="form-row">
                        <label for="phone">연락처</label>
                        <input type="text"
                               id="phone"
                               name="phone"
                               value="${store.phone}">
                    </div>

                    <div class="form-row">
                        <label for="address">주소</label>
                        <input type="text"
                               id="address"
                               name="address"
                               value="${store.address}">
                    </div>

                </div>

                <div class="btn-area">
                    <button type="submit" class="btn-update">
                        수정
                    </button>

                    <button type="button"
                            class="btn-delete"
                            onclick="confirmClose(${store.storeId})">
                        폐점 처리
                    </button>

                    <button type="button"
                            class="btn-list"
                            onclick="location.href='${pageContext.request.contextPath}/admin/stores'">
                        목록으로
                    </button>
                </div>

            </section>

        </form>

    </main>

</t:menubarHO>

	<script>
	function confirmClose(storeId) {
	    const text = prompt("폐점 처리하려면 '폐점처리'를 입력하세요.");
	
	    if (text === "폐점처리") {
	        location.href =
	            "${pageContext.request.contextPath}/admin/stores/"
	            + storeId
	            + "/status";
	    } else if (text !== null) {
	        alert("입력 문구가 일치하지 않아 취소되었습니다.");
	    }
	}
</script>

</body>
</html>