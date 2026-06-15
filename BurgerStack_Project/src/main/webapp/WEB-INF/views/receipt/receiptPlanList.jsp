<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<c:url var="baseUrl" value="/owner/receipts/planned" />

<t:layout>

  <layout:Page title="예정된 입고" description="승인된 발주 건을 확인하고 입고 처리를 진행할 수 있습니다.">

    <jsp:attribute name="actions">
      <a href="${baseUrl}" class="btn btn-secondary">초기화</a>
    </jsp:attribute>

    <jsp:body>

      <layout:Section title="조회 조건">
        <form id="searchForm"
              action="${baseUrl}"
              method="get">

          <input type="hidden" name="page" value="1" />

          <div class="d-flex justify-content-end align-items-center mb-3">

            <select name="status"
                    id="purchaseStatus"
                    class="form-control mr-2"
                    style="width: 150px;"
                    onchange="this.form.submit()">

              <option value="" ${empty status ? 'selected' : ''}>
                전체
              </option>

              <option value="APPROVED" ${status eq 'APPROVED' ? 'selected' : ''}>
                승인
              </option>

              <option value="PARTIALLY_APPROVED" ${status eq 'PARTIALLY_APPROVED' ? 'selected' : ''}>
                부분 승인
              </option>

            </select>

            <input type="date"
                   class="form-control mr-2"
                   style="width: 150px;"
                   name="startDate"
                   id="startDate"
                   value="${param.startDate}" />

            <span class="mr-2">~</span>

            <input type="date"
                   class="form-control mr-2"
                   style="width: 150px;"
                   name="endDate"
                   id="endDate"
                   value="${param.endDate}" />

            <div class="input-group" style="width: 280px;">
              <input type="text"
                     class="form-control"
                     name="keyword"
                     value="${param.keyword}"
                     placeholder="발주번호, 품목명 검색" />

              <div class="input-group-append">
                <button type="submit" class="btn btn-dark">
                  검색
                </button>
              </div>
            </div>

          </div>

        </form>
      </layout:Section>

      <layout:TableSection title="예정된 입고 목록" description="입고 확인 버튼을 클릭하면 입고 검수 화면으로 이동합니다.">

        <table:Table isEmpty="${empty list}" emptyMessage="입고 예정 발주가 없습니다.">

          <jsp:attribute name="thead">
            <tr>
              <th>발주번호</th>
              <th class="text-center">상태</th>
              <th>품목요약</th>
              <th class="text-right">총액</th>
              <th class="text-center">요청일</th>
              <th class="text-center">입고확인</th>
            </tr>
          </jsp:attribute>

          <jsp:attribute name="tbody">
            <c:forEach var="p" items="${list}">

              <c:url var="receiptCheckUrl" value="/owner/purchases/${p.purchaseOrderId}/receipt" />

              <table:TableRow>

                <table:TextFitCell value="${p.purchaseOrderId}" />

                <table:FitCell>
                  <c:choose>
                    <c:when test="${p.status eq 'APPROVED'}">
                      <span class="badge badge-success">승인</span>
                    </c:when>

                    <c:when test="${p.status eq 'PARTIALLY_APPROVED'}">
                      <span class="badge badge-warning">부분 승인</span>
                    </c:when>

                    <c:otherwise>
                      <span class="badge badge-secondary">
                        ${p.status}
                      </span>
                    </c:otherwise>
                  </c:choose>
                </table:FitCell>

                <table:TextCell value="${empty p.materialSummary ? '-' : p.materialSummary}" />

                <table:MoneyCell value="${p.totalAmount}" suffix="원" />

                <table:FitCell>
                  <c:choose>
                    <c:when test="${not empty p.createdAt}">
                      <c:set var="createdAtText" value="${p.createdAt.toString().replace('T', ' ')}" />

                      <c:choose>
                        <c:when test="${fn:length(createdAtText) >= 16}">
                          ${fn:substring(createdAtText, 0, 16)}
                        </c:when>
                        <c:otherwise>
                          ${createdAtText}
                        </c:otherwise>
                      </c:choose>
                    </c:when>

                    <c:otherwise>
                      <span class="text-muted">-</span>
                    </c:otherwise>
                  </c:choose>
                </table:FitCell>

                <table:FitCell>
                  <a href="${receiptCheckUrl}" class="btn btn-primary btn-sm">
                    입고 확인
                  </a>
                </table:FitCell>

              </table:TableRow>

            </c:forEach>
          </jsp:attribute>

        </table:Table>

      </layout:TableSection>

      <div class="mt-3 d-flex justify-content-center">
        <ui:pagination pageInfo="${pageInfo}" />
      </div>

    </jsp:body>
  </layout:Page>
</t:layout>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const searchForm = document.getElementById("searchForm");
    const startDate = document.getElementById("startDate");
    const endDate = document.getElementById("endDate");

    function formatDate(date) {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, "0");
      const day = String(date.getDate()).padStart(2, "0");

      return year + "-" + month + "-" + day;
    }

    const todayText = formatDate(new Date());

    // 시작일, 종료일 둘 다 오늘 이후 선택 불가
    startDate.setAttribute("max", todayText);
    endDate.setAttribute("max", todayText);

    function syncDateLimit() {
      const startValue = startDate.value;
      const endValue = endDate.value;

      // 시작일을 선택하면 종료일은 시작일보다 이전 날짜 선택 불가
      if (startValue !== "") {
        endDate.setAttribute("min", startValue);
      } else {
        endDate.removeAttribute("min");
      }

      // 종료일을 선택하면 시작일은 종료일보다 이후 날짜 선택 불가
      if (endValue !== "") {
        startDate.setAttribute("max", endValue);
      } else {
        startDate.setAttribute("max", todayText);
      }

      // 그래도 시작일 max는 오늘을 넘으면 안 됨
      if (endValue === "" || endValue > todayText) {
        startDate.setAttribute("max", todayText);
      }
    }

    function validateDateRange() {
      const startValue = startDate.value;
      const endValue = endDate.value;

      if (startValue !== "" && startValue > todayText) {
        alert("시작일은 오늘 이후 날짜를 선택할 수 없습니다.");
        startDate.value = "";
        startDate.focus();
        syncDateLimit();
        return false;
      }

      if (endValue !== "" && endValue > todayText) {
        alert("종료일은 오늘 이후 날짜를 선택할 수 없습니다.");
        endDate.value = "";
        endDate.focus();
        syncDateLimit();
        return false;
      }

      if (startValue !== "" && endValue !== "" && startValue > endValue) {
        alert("시작일은 종료일보다 늦을 수 없습니다.");
        startDate.focus();
        syncDateLimit();
        return false;
      }

      return true;
    }

    if (startDate) {
      startDate.addEventListener("change", function() {
        validateDateRange();
        syncDateLimit();
      });
    }

    if (endDate) {
      endDate.addEventListener("change", function() {
        validateDateRange();
        syncDateLimit();
      });
    }

    if (searchForm) {
      searchForm.addEventListener("submit", function(e) {
        if (!validateDateRange()) {
          e.preventDefault();
        }
      });
    }

    syncDateLimit();
  });
</script>