<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 점포 정보</title>

<style>
    .store-info-wrap {
        width: 1000px;
        margin: 55px auto;
    }

    .page-title {
        font-size: 30px;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .page-desc {
        color: #6b7280;
        font-size: 14px;
        margin-bottom: 30px;
    }

    .info-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 35px 40px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    }

    .section-title {
        font-size: 22px;
        font-weight: 700;
        margin-bottom: 28px;
        padding-left: 12px;
        border-left: 5px solid #19c765;
    }

    .info-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px 32px;
    }

    .info-row {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .info-row label {
        font-size: 14px;
        font-weight: 700;
        color: #374151;
    }

    .info-box {
        height: 42px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 0 13px;
        display: flex;
        align-items: center;
        background: #f9fafb;
        color: #111827;
        font-size: 15px;
    }

    .status-badge {
        display: inline-flex;
        align-items: center;
        width: fit-content;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 14px;
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

    .status-rest {
        background: #fef3c7;
        color: #92400e;
    }

    .notice-box {
        margin-top: 30px;
        padding: 15px 18px;
        border-radius: 10px;
        background: #f9fafb;
        border: 1px solid #e5e7eb;
        color: #6b7280;
        font-size: 14px;
        line-height: 1.6;
    }
</style>
</head>

<body>
<t:layout>

    <main class="store-info-wrap">

        <h1 class="page-title">내 점포 정보</h1>
        <p class="page-desc">
            점주 계정에 연결된 점포 정보를 확인할 수 있습니다.
        </p>

        <section class="info-card">

            <h2 class="section-title">점포 정보</h2>

            <div class="info-grid">

                <div class="info-row">
                    <label>점포ID</label>
                    <div class="info-box">${store.storeId}</div>
                </div>

                <div class="info-row">
                    <label>점포명</label>
                    <div class="info-box">${store.storeName}</div>
                </div>

                <div class="info-row">
                    <label>연락처</label>
                    <div class="info-box">${store.phone}</div>
                </div>

                <div class="info-row">
                    <label>주소</label>
                    <div class="info-box">${store.address}</div>
                </div>

                <div class="info-row">
                    <label>상태</label>
                    <div>
                        <c:choose>
                            <c:when test="${store.status eq 'OPEN'}">
                                <span class="status-badge status-open">
                                    영업중
                                </span>
                            </c:when>

                            <c:when test="${store.status eq 'CLOSED'}">
                                <span class="status-badge status-closed">
                                    폐점
                                </span>
                            </c:when>

                            <c:when test="${store.status eq '영업중'}">
                                <span class="status-badge status-open">
                                    영업중
                                </span>
                            </c:when>

                            <c:when test="${store.status eq '폐점'}">
                                <span class="status-badge status-closed">
                                    폐점
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="status-badge status-rest">
                                    ${store.status}
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="info-row">
                    <label>등록일</label>
                    <div class="info-box">
                        ${fn:replace(store.createdAt, 'T', ' ')}
                    </div>
                </div>

            </div>

            <div class="notice-box">
                점포 정보 수정은 본사 관리자에게 문의해 주세요.<br>
                점주는 본인에게 연결된 점포 정보만 조회할 수 있습니다.
            </div>

        </section>

    </main>

</t:layout>
</body>
</html>