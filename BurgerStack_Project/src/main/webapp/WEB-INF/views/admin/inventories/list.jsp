<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <title>Insert title here</title>
    <style></style>
  </head>
  <body>
    <t:menubarHO>
      <h2>재고 목록</h2>

      <table class="table2">
        <thead>
          <tr>
            <th>점포명</th>
            <th>자재명</th>
            <th>현재 수량</th>
            <th>안전재고 수량</th>
            <th>조정</th>
          </tr>
        </thead>

        <tbody>
          <c:forEach var="item" items="${view.list}">
            <tr>
              <td>${item.storeName}</td>
              <td>${item.materialName}</td>
              <td>${item.currentQuantity}</td>
              <td>${item.safetyQuantity}</td>
              <td>
                <c:url var="adjustUrl" value="/admin/inventories/${item.inventoryId}/edit" />
                <a href="${adjustUrl}" class="btn btn-sm btn-outline-primary">조정</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <t:pagination pageInfo="${view.pageInfo}" />
    </t:menubarHO>
  </body>
</html>
