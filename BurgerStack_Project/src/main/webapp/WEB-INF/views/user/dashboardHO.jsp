<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css" />

<t:layout headerTitle="관리자 대시보드">
  <div class="dashboard-wrap">
    <div class="summary-grid">
      <div class="summary-card">
        <div class="summary-title">전체 점포 수</div>
        <div class="summary-count">${view.storeCount}<span>건</span></div>
        <a href="${pageContext.request.contextPath}/admin/stores" class="summary-link"> 점포 관리 바로가기 &gt; </a>
      </div>

      <div class="summary-card">
        <div class="summary-title">발주 요청</div>
        <div class="summary-count">${view.purchaseCount}<span>건</span></div>
        <a href="${pageContext.request.contextPath}/admin/purchases" class="summary-link"> 발주 관리 바로가기 &gt; </a>
      </div>

      <div class="summary-card">
        <div class="summary-title">미답변 문의</div>
        <div class="summary-count">${view.inquiryCount}<span>건</span></div>
        <a href="${pageContext.request.contextPath}/admin/inquiries" class="summary-link"> 문의사항 바로가기 &gt; </a>
      </div>

      <div class="summary-card">
        <div class="summary-title">재고 부족</div>
        <div class="summary-count">${view.belowSafetyInventoryCount}<span>건</span></div>
        <a href="${pageContext.request.contextPath}/admin/inventories?belowSafetyStock=true" class="summary-link"> 재고 관리 바로가기 &gt; </a>
      </div>
    </div>

    <div class="panel-grid">
      <div class="panel-card">
        <div class="panel-head">
          <div class="panel-title">최근 발주 요청</div>
          <a href="${pageContext.request.contextPath}/admin/purchases" class="more-link"> 전체 보기 &gt; </a>
        </div>

        <table class="data-list">
          <thead>
            <tr>
              <th style="width: 22%">발주번호</th>
              <th style="width: 24%">점포명</th>
              <th style="width: 22%">금액</th>
              <th style="width: 17%">상태</th>
              <th style="width: 15%">상세</th>
            </tr>
          </thead>

          <tbody>
            <c:forEach var="order" items="${view.recentPurchaseOrderList}">
              <tr>
                <td>
                  <c:out value="${order.purchaseCode}" />
                </td>

                <td class="text-left">
                  <c:out value="${order.storeName}" />
                </td>

                <td class="text-right"><fmt:formatNumber value="${order.totalAmount}" type="number" />원</td>

                <td>
                  <c:choose>
                    <c:when test="${order.status eq 'REQUESTED'}">
                      <span class="badge badge-orange">요청</span>
                    </c:when>

                    <c:when test="${order.status eq 'PARTIALLY_APPROVED'}">
                      <span class="badge badge-blue">부분 승인</span>
                    </c:when>

                    <c:when test="${order.status eq 'APPROVED'}">
                      <span class="badge badge-blue">승인</span>
                    </c:when>

                    <c:when test="${order.status eq 'REJECTED'}">
                      <span class="badge badge-orange">반려</span>
                    </c:when>

                    <c:when test="${order.status eq 'CANCELED'}">
                      <span class="badge">취소</span>
                    </c:when>

                    <c:when test="${order.status eq 'RECEIVED'}">
                      <span class="badge badge-blue">입고 완료</span>
                    </c:when>

                    <c:otherwise>
                      <span class="badge">
                        <c:out value="${order.status}" />
                      </span>
                    </c:otherwise>
                  </c:choose>
                </td>

                <td>
                  <a href="${pageContext.request.contextPath}/admin/purchases/${order.purchaseOrderId}" class="detail-btn"> 상세보기 </a>
                </td>
              </tr>
            </c:forEach>

            <c:if test="${empty view.recentPurchaseOrderList}">
              <tr>
                <td colspan="5" class="empty-row">최근 발주 요청이 없습니다.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>

      <div class="panel-card">
        <div class="panel-head">
          <div class="panel-title">최근 문의사항</div>
          <a href="${pageContext.request.contextPath}/admin/inquiries" class="more-link"> 전체 보기 &gt; </a>
        </div>

        <table class="data-list">
          <thead>
            <tr>
              <th style="width: 22%">문의번호</th>
              <th style="width: 34%">제목</th>
              <th style="width: 20%">점포명</th>
              <th style="width: 14%">상태</th>
              <th style="width: 10%">상세</th>
            </tr>
          </thead>

          <tbody>
            <c:forEach var="inquiry" items="${view.recentInquiryList}">
              <tr>
                <td>
                  <c:out value="${inquiry.inquiryCode}" />
                </td>

                <td class="text-left">
                  <c:out value="${inquiry.title}" />
                </td>

                <td>
                  <c:out value="${inquiry.storeName}" />
                </td>

                <td>
                  <c:choose>
                    <c:when test="${inquiry.status eq 'REQUESTED'}">
                      <span class="badge badge-orange">문의</span>
                    </c:when>

                    <c:when test="${inquiry.status eq 'ANSWERED'}">
                      <span class="badge badge-blue">답변 완료</span>
                    </c:when>

                    <c:otherwise>
                      <span class="badge">
                        <c:out value="${inquiry.status}" />
                      </span>
                    </c:otherwise>
                  </c:choose>
                </td>

                <td>
                  <a href="${pageContext.request.contextPath}/admin/inquiries/${inquiry.inquiryId}" class="detail-btn"> 상세 </a>
                </td>
              </tr>
            </c:forEach>

            <c:if test="${empty view.recentInquiryList}">
              <tr>
                <td colspan="5" class="empty-row">최근 문의사항이 없습니다.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>

      <div class="panel-card">
        <div class="panel-head">
          <div class="panel-title">점포 상태 현황</div>
          <a href="${pageContext.request.contextPath}/admin/stores" class="more-link"> 전체 보기 &gt; </a>
        </div>

        <div class="chart-panel-body">
          <div class="chart-wrap">
            <canvas id="storeStatusChart"></canvas>
          </div>

          <table class="data-list chart-summary-list">
            <tbody>
              <tr>
                <td class="text-left">
                  <span class="badge badge-blue">영업 중</span>
                </td>
                <td class="text-right">${view.storeStatistics.openStoreCount}건</td>
              </tr>

              <tr>
                <td class="text-left">
                  <span class="badge badge-orange">휴업</span>
                </td>
                <td class="text-right">${view.storeStatistics.pausedStoreCount}건</td>
              </tr>

              <tr>
                <td class="text-left">
                  <span class="badge">폐점</span>
                </td>
                <td class="text-right">${view.storeStatistics.closedStoreCount}건</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="panel-card">
        <div class="panel-head">
          <div class="panel-title">발주 상태 현황</div>
          <a href="${pageContext.request.contextPath}/admin/purchases" class="more-link"> 전체 보기 &gt; </a>
        </div>

        <div class="chart-panel-body">
          <div class="chart-wrap">
            <canvas id="purchaseOrderStatusChart"></canvas>
          </div>

          <table class="data-list chart-summary-list">
            <tbody>
              <tr>
                <td class="text-left">
                  <span class="badge badge-orange">요청</span>
                </td>
                <td class="text-right">${view.purchaseOrderStatistics.requestedCount}건</td>
              </tr>

              <tr>
                <td class="text-left">
                  <span class="badge badge-blue">승인</span>
                </td>
                <td class="text-right">${view.purchaseOrderStatistics.approvedCount}건</td>
              </tr>

              <tr>
                <td class="text-left">
                  <span class="badge">반려</span>
                </td>
                <td class="text-right">${view.purchaseOrderStatistics.rejectedCount}건</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script>
    const storeStatusChart = document.getElementById("storeStatusChart");

    new Chart(storeStatusChart, {
      type: "doughnut",
      data: {
        labels: ["영업 중", "휴업", "폐점"],
        datasets: [{
          data: [
            ${view.storeStatistics.openStoreCount},
            ${view.storeStatistics.pausedStoreCount},
            ${view.storeStatistics.closedStoreCount}
          ],
          backgroundColor: [
            "#3b82f6",
            "#f97316",
            "#9ca3af"
          ],
          borderWidth: 0
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: "65%",
        plugins: {
          legend: {
            display: false
          }
        }
      }
    });

    const purchaseOrderStatusChart = document.getElementById("purchaseOrderStatusChart");

    new Chart(purchaseOrderStatusChart, {
      type: "doughnut",
      data: {
        labels: ["요청", "승인", "반려"],
        datasets: [{
          data: [
            ${view.purchaseOrderStatistics.requestedCount},
            ${view.purchaseOrderStatistics.approvedCount},
            ${view.purchaseOrderStatistics.rejectedCount}
          ],
          backgroundColor: [
            "#f97316",
            "#3b82f6",
            "#9ca3af"
          ],
          borderWidth: 0
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: "65%",
        plugins: {
          legend: {
            display: false
          }
        }
      }
    });
  </script>
</t:layout>
