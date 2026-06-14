<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="t"
    tagdir="/WEB-INF/tags"%>

<title>점주 대시보드</title>

<style>
    .dashboard-wrap {
        padding: 25px 32px;
        background: #f5f7fb;
        min-height: calc(100vh - 70px);
    }

    .page-title {
        margin: 0 0 22px 0;
        font-size: 30px;
        font-weight: bold;
        color: #111827;
    }

    .summary-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 18px;
        margin-bottom: 18px;
    }

    .summary-card,
    .panel-card,
    .notice-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .summary-card {
        padding: 20px 24px;
    }

    .summary-card:nth-child(1) {
        border-left: 5px solid #22c55e;
    }

    .summary-card:nth-child(2) {
        border-left: 5px solid #3b82f6;
    }

    .summary-card:nth-child(3) {
        border-left: 5px solid #f97316;
    }

    .summary-card:nth-child(4) {
        border-left: 5px solid #8b5cf6;
    }

    .summary-title {
        margin-bottom: 12px;
        color: #6b7280;
        font-size: 14px;
        font-weight: bold;
    }

    .summary-count {
        font-size: 38px;
        font-weight: bold;
        color: #111827;
    }

    .summary-count span {
        margin-left: 4px;
        font-size: 16px;
        font-weight: normal;
    }

    .summary-link,
    .more-link {
        color: #6b7280;
        font-size: 13px;
        text-decoration: none;
    }

    .summary-link {
        display: inline-block;
        margin-top: 14px;
    }

    .panel-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 18px;
        margin-bottom: 18px;
    }

    .panel-card {
        padding: 22px 24px;
        min-height: 230px;
    }

    .panel-head {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 18px;
    }

    .panel-title {
        font-size: 20px;
        font-weight: bold;
        color: #111827;
    }

    .data-list {
        width: 100%;
        table-layout: fixed;
        border-collapse: collapse;
    }

    .data-list th {
        padding: 10px 8px;
        font-size: 13px;
        color: #6b7280;
        background: #f9fafb;
        border-bottom: 1px solid #e5e7eb;
        text-align: center;
        font-weight: bold;
    }

    .data-list tr {
        border-bottom: 1px solid #edf0f3;
    }

    .data-list td {
        padding: 11px 8px;
        font-size: 14px;
        color: #374151;
        text-align: center;
        vertical-align: middle;
    }

    .text-left {
        text-align: left !important;
    }

    .text-right {
        text-align: right !important;
    }

    .rank {
        width: 28px;
        height: 28px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: #dcfce7;
        color: #16a34a;
        border-radius: 50%;
        font-weight: bold;
    }

    .badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 8px;
        font-size: 13px;
        font-weight: bold;
    }

    .badge-blue {
        background: #dbeafe;
        color: #2563eb;
    }

    .badge-orange {
        background: #ffedd5;
        color: #f97316;
    }

    .detail-btn {
        display: inline-block;
        padding: 6px 12px;
        background: #eff6ff;
        border: 1px solid #bfdbfe;
        border-radius: 8px;
        color: #2563eb;
        font-size: 13px;
        font-weight: bold;
        text-decoration: none;
        cursor: pointer;
    }

    .detail-btn:hover {
        background: #dbeafe;
    }

    .closing-complete {
        margin-bottom: 18px;
        color: #16a34a;
        font-size: 18px;
        font-weight: bold;
    }

    .closing-open {
        display: flex;
        flex-direction: column;
        justify-content: center;
        height: 120px;
        color: #374151;
    }

    .closing-open strong {
        display: block;
        margin-bottom: 8px;
        font-size: 18px;
    }

    .closing-open p {
        margin: 0;
        color: #6b7280;
        font-size: 14px;
    }

    .closing-info {
        width: 100%;
        border-collapse: collapse;
        border: 1px solid #e5e7eb;
    }

    .closing-info th {
        width: 150px;
        padding: 14px;
        background: #22c55e;
        color: #fff;
        text-align: left;
        font-size: 14px;
    }

    .closing-info td {
        padding: 14px 18px;
        border-bottom: 1px solid #e5e7eb;
        font-size: 14px;
        text-align: left;
    }

    .notice-card {
        padding: 22px 24px;
    }

    .empty-row {
        color: #9ca3af !important;
        padding: 24px 8px !important;
    }
</style>


<t:layout>

    <div class="dashboard-wrap">

        <h1 class="page-title">점주 대시보드</h1>

        <div class="summary-grid">

            <div class="summary-card">
                <div class="summary-title">재고 부족 품목</div>
                <div class="summary-count">${shortageCount}<span>건</span></div>
                <a href="${pageContext.request.contextPath}/owner/inventories"
                   class="summary-link">재고 관리 바로가기 &gt;</a>
            </div>

            <div class="summary-card">
                <div class="summary-title">오늘 입고 예정</div>
                <div class="summary-count">${todayReceiptCount}<span>건</span></div>
                <a href="${pageContext.request.contextPath}/owner/purchases?status=APPROVED"
                   class="summary-link">입고 예정 바로가기 &gt;</a>
            </div>

            <div class="summary-card">
                <div class="summary-title">승인 대기 발주</div>
                <div class="summary-count">${pendingPurchaseCount}<span>건</span></div>
                <a href="${pageContext.request.contextPath}/owner/purchases"
                   class="summary-link">발주 관리 바로가기 &gt;</a>
            </div>

            <div class="summary-card">
                <div class="summary-title">미답변 문의</div>
                <div class="summary-count">${unansweredInquiryCount}<span>건</span></div>
                <a href="${pageContext.request.contextPath}/owner/inquiries"
                   class="summary-link">문의사항 바로가기 &gt;</a>
            </div>

        </div>

        <div class="panel-grid">

            <div class="panel-card">
                <div class="panel-head">
                    <div class="panel-title">재고 부족 TOP5</div>
                    <a href="${pageContext.request.contextPath}/owner/inventories"
                       class="more-link">전체 보기 &gt;</a>
                </div>

                <table class="data-list">
                    <thead>
                        <tr>
                            <th style="width:15%;">순위</th>
                            <th style="width:35%;">품목명</th>
                            <th style="width:25%;">현재고</th>
                            <th style="width:25%;">안전재고</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="s" items="${shortageList}" varStatus="status">
                            <tr>
                                <td><span class="rank">${status.count}</span></td>
                                <td>${s.MATERIALNAME}</td>
                                <td class="text-right">${s.CURRENTQUANTITY}개</td>
                                <td class="text-right">${s.SAFETYQUANTITY}개</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty shortageList}">
                            <tr>
                                <td colspan="4" class="empty-row">
                                    부족 재고가 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <div class="panel-card">
                <div class="panel-head">
                    <div class="panel-title">오늘 입고 예정</div>
                    <a href="${pageContext.request.contextPath}/owner/purchases?status=APPROVED"
                       class="more-link">전체 보기 &gt;</a>
                </div>

                <table class="data-list">
                    <thead>
                        <tr>
                            <th style="width:20%;">입고번호</th>
                            <th style="width:55%;">품목요약</th>
                            <th style="width:25%;">상세</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="r" items="${todayReceiptList}">
						    <tr>
						        <td>
						            <span class="badge badge-blue">${r.RECEIPTID}</span>
						        </td>
						
						        <td>
						            ${r.MATERIALNAME}
						            <c:if test="${r.EXTRACOUNT > 0}">
						                외 ${r.EXTRACOUNT}건
						            </c:if>
						        </td>
						
						        <td>
						            <a href="${pageContext.request.contextPath}/owner/purchases/${r.RECEIPTID}/receipt"
						               class="detail-btn">
						                상세보기
						            </a>
						        </td>
						    </tr>
						</c:forEach>

                        <c:if test="${empty todayReceiptList}">
                            <tr>
                                <td colspan="3" class="empty-row">
                                    오늘 입고 예정이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <div class="panel-card">
                <div class="panel-head">
                    <div class="panel-title">미처리 발주</div>
                    <a href="${pageContext.request.contextPath}/owner/purchases"
                       class="more-link">전체 보기 &gt;</a>
                </div>

                <table class="data-list">
                    <tbody>
                        <c:forEach var="p" items="${purchaseStatusList}">
                            <tr>
                                <td class="text-left">
                                    <span class="badge badge-orange">
                                        <c:choose>
                                            <c:when test="${p.STATUS eq 'REQUESTED'}">
                                                승인 대기
                                            </c:when>
                                            <c:when test="${p.STATUS eq 'PARTIALLY_APPROVED'}">
                                                부분 승인
                                            </c:when>
                                            <c:otherwise>
                                                ${p.STATUS}
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>

                                <td class="text-right">${p.COUNT}건</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty purchaseStatusList}">
                            <tr>
                                <td colspan="2" class="empty-row">
                                    미처리 발주가 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <div class="panel-card">
                <div class="panel-head">
                    <div class="panel-title">일일 마감 상태</div>
                    <a href="${pageContext.request.contextPath}/owner/closings"
                       class="more-link">마감 내역 보기 &gt;</a>
                </div>

                <c:choose>
                    <c:when test="${not empty closing}">
                        <div class="closing-complete">✓ 마감 완료</div>

                        <table class="closing-info">
                            <tr>
                                <th>마감번호</th>
                                <td>${closing.CLOSINGNO}</td>
                            </tr>
                            <tr>
                                <th>영업일</th>
                                <td>${closing.BUSINESSDATE}</td>
                            </tr>
                            <tr>
                                <th>마감메모</th>
                                <td>${closing.CLOSINGMEMO}</td>
                            </tr>
                            <tr>
                                <th>마감일시</th>
                                <td>${closing.CLOSINGDATE}</td>
                            </tr>
                        </table>
                    </c:when>

                    <c:otherwise>
                        <div class="closing-open">
                            <strong>아직 영업 중입니다.</strong>
                            <p>오늘의 마감이 완료되지 않았습니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <div class="notice-card">
            <div class="panel-head">
                <div class="panel-title">공지사항</div>
                <a href="${pageContext.request.contextPath}/owner/notices"
                   class="more-link">전체 보기 &gt;</a>
            </div>

            <table class="data-list">
                <tbody>
                    <c:forEach var="n" items="${noticeList}">
                        <tr>
                            <td style="width:15%;">
                                <span class="badge badge-blue">공지</span>
                            </td>
                            <td class="text-left">${n.NOTICETITLE}</td>
                            <td style="width:20%;" class="text-right">${n.CREATEDAT}</td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty noticeList}">
                        <tr>
                            <td colspan="3" class="empty-row">
                                등록된 공지사항이 없습니다.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div>

</t:layout>

