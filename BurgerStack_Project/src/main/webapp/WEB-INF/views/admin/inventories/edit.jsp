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
      <h2>재고 조정(미완성)</h2>

      <table class="table2">
        <thead>
          <tr>
            <th>점포명</th>
            <th>자재명</th>
            <th>현재 수량</th>
            <th>안전재고 수량</th>
          </tr>
        </thead>

        <tbody>
          <tr>
            <td>${detail.storeName}</td>
            <td>${detail.materialName}</td>
            <td>${detail.currentQuantity}</td>
            <td>${detail.safetyQuantity}</td>
          </tr>
        </tbody>
      </table>
    </t:menubarHO>
  </body>
</html>
