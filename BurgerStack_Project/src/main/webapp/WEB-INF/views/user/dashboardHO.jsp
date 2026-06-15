<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css" />

<c:url var="inquiryListUrl" value="/admin/inquiries"></c:url>
<c:url var="purchaseListUrl" value="/admin/purchases"></c:url>
<c:url var="storeListUrl" value="/admin/stores"></c:url>

<t:layout>
  <div class="dashboard__container">
    <div class="card dashboard__panel dashboard__panel--small">
      <div class="card-body">
        <div class="card-title dashboard__card-title">전체 점포 수</div>
        <div class="card-text dashboard__count">${view.storeCount}<span>건</span></div>
        <a class="card-link" href="${storeListUrl}"> 점포 관리 바로가기 &gt; </a>
      </div>
    </div>
    <div class="card dashboard__panel dashboard__panel--small">
      <div class="card-body">
        <div class="card-title dashboard__card-title">발주 요청</div>
        <div class="card-text dashboard__count">${view.purchaseCount}<span>건</span></div>
        <a class="card-link" href="${purchaseListUrl}"> 발주 관리 바로가기 &gt; </a>
      </div>
    </div>
    <div class="card dashboard__panel dashboard__panel--small">
      <div class="card-body">
        <div class="card-title dashboard__card-title">미답변 문의</div>
        <div class="card-text dashboard__count">${view.storeCount}<span>건</span></div>
        <a class="card-link" href="${inquiryListUrl}"> 문의사항 바로가기 &gt; </a>
      </div>
    </div>
    <div class="card dashboard__panel dashboard__panel--small">
      <div class="card-body">
        <div class="dashboard__chart-container">
          <div class="dashboard__chart-box">
            <canvas id="storeStatusChart"></canvas>
          </div>
          <div class="dashboard__chart-box">
            <canvas id="purchaseOrderStatusChart"></canvas>
          </div>
        </div>
      </div>
    </div>

    <div class="card dashboard__panel dashboard__panel--big">
      <div class="card-body">
        <div class="card-title d-flex flex-row justify-content-between">
          <h5>최근 발주 요청</h5>
          <a href="${purchaseListUrl}"> 전체 보기 &gt; </a>
        </div>

        <table:Table isEmpty="${empty view.recentPurchaseOrderList}" emptyMessage="최근 발주 요청이 없습니다.">
          <jsp:attribute name="thead">
            <tr>
              <th class="text-left">발주코드</th>
              <th class="text-left">점포명</th>
              <th class="text-right">금액</th>
              <th class="text-left">상태</th>
            </tr>
          </jsp:attribute>

          <jsp:attribute name="tbody">
            <c:forEach var="order" items="${view.recentPurchaseOrderList}">
              <c:url var="purchaseOrderDetailUrl" value="/admin/purchases/${order.purchaseOrderId}"></c:url>
              <table:TableRow clickable="true" href="${purchaseOrderDetailUrl}">
                <table:TextFitCell value="${order.purchaseCode}" />
                <table:TextCell value="${order.storeName}" />
                <table:MoneyCell value="${order.totalAmount}" suffix="원" />
                <table:FitCell align="left">
                  <display:PurchaseStatusBadge value="${order.status}" />
                </table:FitCell>
              </table:TableRow>
            </c:forEach>
          </jsp:attribute>
        </table:Table>
      </div>
    </div>

    <div class="card dashboard__panel dashboard__panel--big">
      <div class="card-body">
        <div class="card-title d-flex flex-row justify-content-between">
          <h5>최근 문의사항</h5>
          <a href="${inquiryListUrl}"> 전체 보기 &gt; </a>
        </div>

        <table:Table isEmpty="${empty view.recentInquiryList}" emptyMessage="최근 문의사항이 없습니다.">
          <jsp:attribute name="thead">
            <tr>
              <th class="text-left">No</th>
              <th class="text-left">제목</th>
              <th class="text-left">점포명</th>
              <th class="text-left">상태</th>
            </tr>
          </jsp:attribute>

          <jsp:attribute name="tbody">
            <c:forEach var="inquiry" items="${view.recentInquiryList}">
              <c:url var="inquiryDetailUrl" value="/admin/inquiries/${inquiry.inquiryId}"></c:url>
              <table:TableRow clickable="true" href="${inquiryDetailUrl}">
                <table:NumberCell value="${inquiry.inquiryId}" />
                <table:TextCell value="${inquiry.title}" />
                <table:TextFitCell value="${inquiry.storeName}" />
                <table:FitCell align="left">
                  <display:InquiryStatusBadge value="${inquiry.status}" />
                </table:FitCell>
              </table:TableRow>
            </c:forEach>
          </jsp:attribute>
        </table:Table>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0"></script>
  <script>
    Chart.register(ChartDataLabels);
    Chart.defaults.set("plugins.datalabels", {
      color: "#FFFFFF",
      backgroundColor: "#616161c4",
      formatter: function (value, context) {
        return context.chart.data.labels[context.dataIndex] + ": " + context.dataset.data[context.dataIndex];
      },
    });

    Chart.defaults.set("plugins.legend", {
      display: false,
    });

    const storeStatusChart = document.getElementById("storeStatusChart");
    new Chart(storeStatusChart, {
      type: "doughnut",
      data: {
        labels: ["영업 중", "휴업", "폐점"],
        datasets: [
          {
            data: ["${view.storeStatistics.openStoreCount}", "${view.storeStatistics.pausedStoreCount}", "${view.storeStatistics.closedStoreCount}"],
            backgroundColor: ["#3b82f6", "#f97316", "#9ca3af"],
            borderWidth: 0,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: true,
        cutout: "65%",
        events: [],
        layout: {
          padding: 10,
        },
      },
    });

    const purchaseOrderStatusChart = document.getElementById("purchaseOrderStatusChart");

    new Chart(purchaseOrderStatusChart, {
      type: "doughnut",
      data: {
        labels: ["요청", "승인", "반려"],
        datasets: [
          {
            data: ["${view.purchaseOrderStatistics.requestedCount}", "${view.purchaseOrderStatistics.approvedCount}", "${view.purchaseOrderStatistics.rejectedCount}"],
            backgroundColor: ["#f97316", "#3b82f6", "#9ca3af"],
            borderWidth: 0,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: true,
        cutout: "65%",
        events: [],
        layout: {
          padding: 10,
        },
      },
    });
  </script>
</t:layout>
