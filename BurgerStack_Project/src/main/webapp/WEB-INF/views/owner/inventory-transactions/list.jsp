<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<c:url var="inventoryTransactionListUrl" value="/owner/inventory-transactions" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>재고 변동 이력 목록</title>
    <style></style>
  </head>
  <body>
    <t:layout>
      <div class="outer">
        <div class="d-flex justify-content-between mb-3">
          <h2>재고 변동 이력 목록</h2>
          <a href="${inventoryTransactionListUrl}" class="btn btn-secondary">초기화</a>
        </div>

        <form class="d-flex justify-content-between mb-3 text-nowrap" action="${inventoryTransactionListUrl}" method="get">
          <input type="hidden" name="page" value="1" />
          <input type="hidden" name="size" value="${view.pageInfo.size}" />

          <select id="transaction-type-option" name="transactionType" class="form-control mr-3">
            <option value="">유형 선택</option>
            <option value="RECEIPT" ${view.condition.transactionType eq 'RECEIPT' ? 'selected' : ''}>입고</option>
            <option value="STORE_CLOSING" ${view.condition.transactionType eq 'STORE_CLOSING' ? 'selected' : ''}>마감</option>
            <option value="ADJUSTMENT" ${view.condition.transactionType eq 'ADJUSTMENT' ? 'selected' : ''}>조정</option>
          </select>
        </form>

        <table class="table2">
          <thead>
            <tr>
              <th>변동 유형</th>
              <th>처리자</th>
              <th>처리 일시</th>
              <th>사유</th>
            </tr>
          </thead>

          <tbody>
            <c:forEach var="item" items="${view.list}">
              <c:url var="detail" value="/owner/inventory-transactions/${item.inventoryTransactionId}" />
              <tr class="clickable-row" data-href="${detail}">
                <td>${item.transactionType}</td>
                <td>${item.createdByName}</td>
                <td>${item.createdAt}</td>
                <td>${item.reason}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <t:pagination pageInfo="${view.pageInfo}" />
      </div>
    </t:layout>
    <script>
      sessionStorage.setItem("inventoryTransactionListUrl", window.location.pathname + window.location.search);
      $(() => {
        $("#transaction-type-option").on("change", () => $("form").submit());
        $(".clickable-row").click((e) => {
          location.href = $(e.target).closest(".clickable-row").attr("data-href");
        });
      });
    </script>
  </body>
</html>
