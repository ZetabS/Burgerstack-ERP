<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<c:url var="baseUrl" value="/owner/receipts" />

<t:layout>

  <layout:Page title="입고 이력" description="입고 완료된 이력을 조회하고 상세 정보를 확인할 수 있습니다.">

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

            <button type="submit" class="btn btn-dark">
              조회
            </button>

          </div>
        </form>
      </layout:Section>

      <layout:TableSection title="입고 이력 목록" description="행을 클릭하면 상세 정보를 확인할 수 있습니다.">

        <table:Table isEmpty="${empty list}" emptyMessage="입고 이력이 없습니다.">

          <jsp:attribute name="thead">
            <tr>
              <th>입고 코드</th>
              <th>품목요약</th>
              <th class="text-center">상태</th>
              <th class="text-center">입고 완료일시</th>
            </tr>
          </jsp:attribute>

          <jsp:attribute name="tbody">
            <c:forEach var="r" items="${list}">
              <c:url var="detailUrl" value="/owner/receipts/${r.receiptId}" />

              <c:set var="receiptCodeText" value="${r.receiptCode}" />
              <c:if test="${empty receiptCodeText}">
                <c:set var="receiptCodeText" value="R${r.receiptId}" />
              </c:if>

              <table:TableRow clickable="true" href="${detailUrl}">

                <table:TextFitCell value="${receiptCodeText}" />

                <table:TextCell value="${empty r.materialSummary ? '-' : r.materialSummary}" />

                <table:FitCell>
                  <c:choose>
                    <c:when test="${r.receiptStatus eq 'DIFFERENCE'}">
                      <span class="badge badge-warning">차이 있음</span>
                    </c:when>

                    <c:when test="${r.receiptStatus eq 'NORMAL'}">
                      <span class="badge badge-success">정상 입고</span>
                    </c:when>

                    <c:otherwise>
                      <span class="badge badge-secondary">
                        ${r.receiptStatus}
                      </span>
                    </c:otherwise>
                  </c:choose>
                </table:FitCell>

                <table:FitCell>
                  <c:choose>
                    <c:when test="${not empty r.receivedAt}">
                      ${r.receivedAt.toString().replace('T', ' ')}
                    </c:when>
                    <c:otherwise>
                      <span class="text-muted">-</span>
                    </c:otherwise>
                  </c:choose>
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

    const today = new Date();
    const yesterday = new Date();

    yesterday.setDate(today.getDate() - 1);

    const todayText = formatDate(today);
    const yesterdayText = formatDate(yesterday);

    if (startDate) {
      startDate.setAttribute("max", yesterdayText);
    }

    if (endDate) {
      endDate.setAttribute("max", todayText);
    }

    function validateDateRange() {
      const startValue = startDate.value;
      const endValue = endDate.value;

      if (startValue !== "" && startValue >= todayText) {
        alert("시작일은 오늘 이전 날짜만 선택할 수 있습니다.");
        startDate.value = "";
        startDate.focus();
        return false;
      }

      if (endValue !== "" && endValue > todayText) {
        alert("종료일은 오늘까지만 선택할 수 있습니다.");
        endDate.value = "";
        endDate.focus();
        return false;
      }

      if (startValue !== "" && endValue !== "" && startValue > endValue) {
        alert("시작일은 종료일보다 늦을 수 없습니다.");
        startDate.focus();
        return false;
      }

      return true;
    }

    if (searchForm) {
      searchForm.addEventListener("submit", function(e) {
        if (!validateDateRange()) {
          e.preventDefault();
        }
      });
    }

    if (startDate) {
      startDate.addEventListener("change", function() {
        validateDateRange();
      });
    }

    if (endDate) {
      endDate.addEventListener("change", function() {
        validateDateRange();
      });
    }
  });
</script>