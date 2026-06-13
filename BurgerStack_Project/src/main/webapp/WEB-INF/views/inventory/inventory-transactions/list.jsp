<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/ui" %>
<c:set var="isAdmin" value="${sessionScope.loginUser.admin}" />
<c:set var="role" value="${isAdmin ? 'admin' : 'owner'}" />
<c:url var="inventoryTransactionListUrl" value="/${role}/inventory-transactions" />
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

          <c:if test="${isAdmin}">
            <select id="store-option" name="storeId" class="form-control mr-3">
              <option value="">점포 선택</option>
              <c:forEach var="option" items="${view.storeOptions}">
                <option value="${option.storeId}" ${option.storeId eq view.condition.storeId ? 'selected' : ''}>${option.storeName}</option>
              </c:forEach>
            </select>
          </c:if>

          <select id="transaction-type-option" name="transactionType" class="form-control mr-3">
            <option value="">유형 선택</option>
            <option value="RECEIPT" ${view.condition.transactionType eq 'RECEIPT' ? 'selected' : ''}>입고</option>
            <option value="STORE_CLOSING" ${view.condition.transactionType eq 'STORE_CLOSING' ? 'selected' : ''}>마감</option>
            <option value="ADJUSTMENT" ${view.condition.transactionType eq 'ADJUSTMENT' ? 'selected' : ''}>조정</option>
          </select>
        </form>

        <ui:DataTable>
          <jsp:attribute name="thead">
            <tr>
              <th>변동 유형</th>
              <c:if test="${isAdmin}">
                <th>점포명</th>
              </c:if>
              <th>처리자</th>
              <th>처리 일시</th>
              <th>사유</th>
            </tr>
          </jsp:attribute>
          <jsp:attribute name="tbody">
            <c:forEach var="item" items="${view.list}">
              <c:url var="detail" value="/${role}/inventory-transactions/${item.inventoryTransactionId}" />
              <ui:TableRow clickable="true" href="${detail}">
                <td>${item.transactionType}</td>
                <c:if test="${isAdmin}">
                  <td>${item.storeName}</td>
                </c:if>
                <td>${item.createdByName}</td>
                <td>${item.createdAt}</td>
                <td>${item.reason}</td>
              </ui:TableRow>
            </c:forEach>
          </jsp:attribute>
        </ui:DataTable>
        <t:pagination pageInfo="${view.pageInfo}" />
      </div>
    </t:layout>
    <script>
      sessionStorage.setItem("inventoryTransactionListUrl", window.location.pathname + window.location.search);
      $(() => {
        $("#store-option").on("change", () => $("form").submit());
        $("#transaction-type-option").on("change", () => $("form").submit());
      });
    </script>
  </body>
</html>
