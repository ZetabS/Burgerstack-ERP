<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점포 상세 정보 조회</title>

<style>
    .store-detail-wrap {
        width: 1000px;
        margin: 55px auto;
    }

    .page-title {
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .page-desc {
        color: #6b7280;
        font-size: 14px;
        margin-bottom: 30px;
    }

    .form-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 35px 40px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    }

    .section-title {
        font-size: 22px;
        font-weight: 700;
        margin-bottom: 24px;
        padding-left: 12px;
        border-left: 5px solid #19c765;
    }

    .info-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 32px;
        font-size: 14px;
    }

    .info-table th {
        width: 180px;
        background: #19c765;
        color: #fff;
        padding: 14px;
        text-align: center;
        font-weight: 700;
        border-bottom: 1px solid #e5e7eb;
    }

    .info-table td {
        padding: 14px 18px;
        border-bottom: 1px solid #e5e7eb;
        color: #111827;
    }

    .status-badge {
        display: inline-block;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 700;
    }

    .status-open {
        background: #dcfce7;
        color: #166534;
    }

    .status-closed {
        background: #fee2e2;
        color: #b91c1c;
    }

    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px 32px;
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
        font-weight: 700;
        color: #374151;
    }

    .form-row input,
    .form-row select {
        height: 42px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 0 13px;
        font-size: 15px;
        background: #fff;
    }

    .form-row input:focus,
    .form-row select:focus {
        outline: none;
        border-color: #19c765;
        box-shadow: 0 0 0 2px rgba(25,199,101,0.15);
    }

    .readonly-box {
        height: 42px;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        padding: 0 13px;
        font-size: 15px;
        background: #f9fafb;
        color: #374151;
        display: flex;
        align-items: center;
    }

    .divider {
        margin: 32px 0 22px;
        border: none;
        border-top: 1px solid #e5e7eb;
    }

    .btn-area {
        display: flex;
        justify-content: center;
        gap: 12px;
    }

    .update-btn {
        height: 42px;
        min-width: 110px;
        border: none;
        border-radius: 8px;
        background: #19c765;
        color: #fff;
        font-weight: 700;
        cursor: pointer;
    }

    .update-btn:hover {
        background: #15b85c;
    }

    .list-btn {
        height: 42px;
        min-width: 110px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        background: #fff;
        color: #374151;
        font-weight: 700;
        cursor: pointer;
    }

    .list-btn:hover {
        background: #f3f4f6;
        color: #374151;
    }
</style>
</head>

<body>

<t:layout>

    <main class="store-detail-wrap">

        <h1 class="page-title">점포 상세 정보 조회</h1>
        <p class="page-desc">
            점포 정보를 확인하고 수정할 수 있습니다.
        </p>

        <section class="form-card">

            <h2 class="section-title">점포 정보</h2>

            <table class="info-table">
                <tr>
                    <th>점포 코드</th>
                    <td>
                        <c:choose>
                            <c:when test="${not empty store.storeCode}">
                                ${store.storeCode}
                            </c:when>
                            <c:otherwise>
                                S${store.storeId}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>대표 점주</th>
                    <td>
                        <c:choose>
                            <c:when test="${not empty store.ownerName}">
                                ${store.ownerName}
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${store.status eq 'OPEN'}">
                                <span class="status-badge status-open">영업중</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-closed">폐점</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>등록일</th>
                    <td>
                        <c:choose>
                            <c:when test="${not empty store.createdAt}">
                                ${store.createdAt.toString().replace('T',' ').substring(0,19)}
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>

            <h2 class="section-title">점포 수정</h2>

            <form action="${pageContext.request.contextPath}/admin/stores/${store.storeId}/update"
                  method="post"
                  onsubmit="return checkStoreUpdate();">

                <input type="hidden" name="storeId" value="${store.storeId}">
                <input type="hidden" id="originalStatus" value="${store.status}">

                <div class="form-grid">

                    <div class="form-row">
                        <label>점포명</label>
                        <input type="text"
                               name="storeName"
                               value="${store.storeName}"
                               required>
                    </div>

                    <div class="form-row">
                        <label>점포 연락처</label>
                        <input type="text"
                               name="phone"
                               value="${store.phone}"
                               placeholder="예: 02-1234-5678">
                    </div>

                    <div class="form-row full">
                        <label>주소</label>
                        <input type="text"
                               name="address"
                               value="${store.address}">
                    </div>

                    <div class="form-row">
                        <label>상태</label>
                        <select name="status" id="status">
                            <option value="OPEN" ${store.status eq 'OPEN' ? 'selected' : ''}>
                                영업중
                            </option>
                            <option value="CLOSED" ${store.status eq 'CLOSED' ? 'selected' : ''}>
                                폐점
                            </option>
                        </select>
                    </div>

                    <div class="form-row">
                        <label>대표 점주</label>
                        <div class="readonly-box">
                            <c:choose>
                                <c:when test="${not empty store.ownerName}">
                                    ${store.ownerName}
                                </c:when>
                                <c:otherwise>
                                    -
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                </div>

                <hr class="divider">

                <div class="btn-area">
                    <button type="submit" class="update-btn">
                        수정
                    </button>

                    <button type="button"
                            class="list-btn"
                            onclick="location.href='${pageContext.request.contextPath}/admin/stores'">
                        목록으로
                    </button>
                </div>

            </form>

        </section>

    </main>

</t:layout>

<script>
    function checkStoreUpdate() {

        const originalStatus = document.getElementById("originalStatus").value;
        const status = document.getElementById("status").value;

        if (originalStatus !== "CLOSED" && status === "CLOSED") {

            const input = prompt("폐점 처리하려면 '폐점처리'를 입력하세요.");

            if (input !== "폐점처리") {
                alert("입력값이 올바르지 않아 폐점 처리가 취소되었습니다.");
                return false;
            }

            return confirm("정말 해당 점포를 폐점 처리하시겠습니까?");
        }

        return confirm("점포 정보를 수정하시겠습니까?");
    }
</script>

</body>
</html>