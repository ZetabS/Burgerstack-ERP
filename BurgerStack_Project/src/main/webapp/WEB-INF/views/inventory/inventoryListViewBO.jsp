<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <jsp:include page="../common/header.jsp" />
    <title>Insert title here</title>
    <style></style>
  </head>
  <body>
    <t:menubarBO>
      <h2>재고 목록</h2>

      <table class="table2">
        <thead>
          <tr>
            <th>자재명</th>
            <th>현재 수량</th>
            <th>안전재고 수량</th>
          </tr>
        </thead>

        <tbody>
          <c:forEach var="item" items="${view.list}">
            <tr>
              <td>${item.materialName}</td>
              <td>${item.currentQuantity}</td>
              <td>${item.safetyQuantity}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <t:pagination pageInfo="${pageInfo}"></t:pagination>
    </t:menubarBO>
  </body>
</html>
