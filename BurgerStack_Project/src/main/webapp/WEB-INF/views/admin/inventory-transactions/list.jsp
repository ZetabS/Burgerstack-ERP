<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <title>재고 변동 이력 목록</title>
    <style></style>
  </head>
  <body>
    <t:menubarHO>
      <h2>재고 변동 이력 목록</h2>

      <table class="table2">
        <thead>
          <tr>
            <th>점포명</th>
            <th>유형</th>
            <th>변동일시</th>
            <th>사유</th>
            <th>작업자</th>
          </tr>
        </thead>

        <tbody>
          <c:forEach var="item" items="${view.list}">
            <c:url var="detail" value="/admin/inventory-transactions/${item.inventoryTransactionId}" />
            <tr class="clickable-row" data-href="${detail}">
              <td>${item.storeName}</td>
              <td>${item.transactionType}</td>
              <td>${item.createdAt}</td>
              <td>${item.reason}</td>
              <td>${item.createdByName}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <t:pagination pageInfo="${view.pageInfo}" />
    </t:menubarHO>
    <script>
      $(() => {
        $(".clickable-row").click((e) => {
          location.href = $(e.target).closest(".clickable-row").attr("data-href");
        });
      });
    </script>
  </body>
</html>
