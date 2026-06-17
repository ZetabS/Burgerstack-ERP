<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="t"
    tagdir="/WEB-INF/tags"%>

<title>점주 대시보드</title>

<style>
    .dashboard-wrap {
        padding: 25px 32px;
        background: #f5f7fb;
        min-height: calc(100vh - 70px);
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

    .summary-status {
        font-size: 32px;
        font-weight: bold;
        color: #111827;
    }

    .summary-status.complete {
        color: #16a34a;
    }

    .summary-status.open {
        color: #f97316;
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

    .summary-link:hover,
    .more-link:hover {
        color: #111827;
        text-decoration: underline;
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

    .status-badge {
	    display: inline-block;
	    padding: 3px 8px;
	    border-radius: 4px;
	    font-size: 12px;
	    font-weight: 700;
	    line-height: 1.2;
	    min-width: auto;
	    text-align: center;
	    white-space: nowrap;
	}

	/* 승인 */
	.status-badge.approved {
	    background-color: #16a34a;
	    color: #ffffff;
	}

	/* 부분승인 */
	.status-badge.partial {
	    background-color: #facc15;
	    color: #111827;
	}

    .clickable-row {
        cursor: pointer;
    }

    .clickable-row:hover {
        background: #f9fafb;
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

    .notice-card {
        padding: 22px 24px;
    }

    .empty-row {
        color: #9ca3af !important;
        padding: 24px 8px !important;
    }
</style>


<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd" />

<t:layout>

    <div class="dashboard-wrap">

        <div class="summary-grid">

            <div class="summary-card">
                <div class="summary-title">재고 부족 품목</div>
                <div class="summary-count"><c:out value="${shortageCount}" /><span>건</span></div>
                <a href="${pageContext.request.contextPath}/owner/inventories"
                   class="summary-link">재고 관리 바로가기 &gt;</a>
            </div>

            <div class="summary-card">
			    <div class="summary-title">오늘 입고 예정</div>
			    <div class="summary-count"><c:out value="${todayReceiptCount}" /><span>건</span></div>

			    <a href="${pageContext.request.contextPath}/owner/receipts/planned?status=ALL"
			       class="summary-link">
			        입고 예정 바로가기 &gt;
			    </a>
			</div>

            <div class="summary-card">
                <div class="summary-title">승인 대기 발주</div>
                <div class="summary-count"><c:out value="${pendingPurchaseCount}" /><span>건</span></div>
                <a href="${pageContext.request.contextPath}/owner/purchases?status=REQUESTED"
                   class="summary-link">발주 관리 바로가기 &gt;</a>
            </div>

            <div class="summary-card">
                <div class="summary-title">일일 마감 상태</div>

                <c:choose>
                    <c:when test="${not empty closing}">
                        <div class="summary-status complete">마감 완료</div>
                        <a href="${pageContext.request.contextPath}/owner/closings"
                           class="summary-link">마감 내역 보기 &gt;</a>
                    </c:when>

                    <c:otherwise>
                        <div class="summary-status open">영업중</div>
                        <a href="${pageContext.request.contextPath}/owner/closings/new"
                           class="summary-link">마감 처리하기 &gt;</a>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <div class="panel-grid">

            <div class="panel-card">
                <div class="panel-head">
                    <div class="panel-title">재고 부족 TOP5</div>
                    <a href="${pageContext.request.contextPath}/owner/purchases/new"
                       class="more-link">발주 요청 바로가기 &gt;</a>
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
                                <td><span class="rank"><c:out value="${status.count}" /></span></td>
                                <td><c:out value="${s.MATERIALNAME}" /></td>
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
                    <a href="${pageContext.request.contextPath}/owner/receipts/planned"
                       class="more-link">전체 보기 &gt;</a>
                </div>

                <table class="data-list">
                    <thead>
                        <tr>
                            <th style="width:20%;">입고번호</th>
                            <th style="width:20%;">상태</th>
                            <th style="width:35%;">품목요약</th>
                            <th style="width:25%;">상세</th>
                        </tr>
                    </thead>

                    <tbody>
                            <c:forEach var="r" items="${todayReceiptList}">
							    <tr>
							        <td><c:out value="${r.purchaseOrderId}" /></td>

							        <td>
									    <c:choose>
									        <c:when test="${r.status eq 'APPROVED'}">
									            <span class="status-badge approved">승인</span>
									        </c:when>

									        <c:when test="${r.status eq 'PARTIALLY_APPROVED'}">
									            <span class="status-badge partial">부분승인</span>
									        </c:when>
									    </c:choose>
									</td>

							        <td>
							            ${r.materialName}
							            <c:if test="${r.extraCount > 0}">
							                외 ${r.extraCount}건
							            </c:if>
							        </td>

							        <td>
							            <a class="detail-btn"
										   href="${pageContext.request.contextPath}/owner/receipts/${r.purchaseOrderId}/receipt">
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
                        <c:set var="noticeTargetId" value="${n.NOTICEID}" />
                        <c:if test="${empty noticeTargetId}">
                            <c:set var="noticeTargetId" value="${n.noticeId}" />
                        </c:if>

                        <tr class="clickable-row"
                            onclick="location.href='${pageContext.request.contextPath}/owner/notices/${noticeTargetId}'">
                            <td style="width:15%;">
                                <span class="badge badge-blue">공지</span>
                            </td>
                            <td class="text-left"><c:out value="${n.NOTICETITLE}" /></td>
                            <td style="width:20%;" class="text-right"><c:out value="${n.CREATEDAT}" /></td>
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


