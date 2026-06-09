<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<c:url var="inventoryListUrl" value="/owner/inventories" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <title>재고 목록</title>
    <style></style>
  </head>
  <body>
    <t:menubarBO>
      <div class="d-flex justify-content-between mb-3">
        <h2>재고 목록</h2>
        <a href="${inventoryListUrl}" class="btn btn-secondary">초기화</a>
      </div>
      <form class="d-flex justify-content-between mb-3 text-nowrap" action="${inventoryListUrl}" method="get">
        <input type="hidden" name="page" value="1" />
        <input type="hidden" name="size" value="${view.pageInfo.size}" />

        <select id="material-type-option" name="materialType" class="form-control mr-3">
          <option value="">유형 선택</option>
          <option value="INGREDIENT" ${view.condition.materialType eq 'INGREDIENT' ? 'selected' : ''}>식자재</option>
          <option value="CONSUMABLE" ${view.condition.materialType eq 'CONSUMABLE' ? 'selected' : ''}>소모품</option>
        </select>

        <div class="form-check mr-3">
          <input class="form-check-input" type="checkbox" name="belowSafetyStock" value="true" id="below-safety-checkbox" ${view.condition.belowSafetyStock eq true ? 'checked' : ''} />
          <label class="form-check-label" for="below-safety-checkbox">안전재고 미만</label>
        </div>
        <input type="text" id="material-name-input" name="materialName" class="form-control mr-3" placeholder="검색할 자재명을 입력하세요." value="${view.condition.materialName}" />
        <button type="submit" class="btn btn-primary">검색</button>
      </form>
      <table class="table2">
        <thead>
          <tr>
            <th>자재명</th>
            <th>현재 수량</th>
            <th>안전재고 수량</th>
            <th>조정</th>
          </tr>
        </thead>

        <tbody>
          <c:forEach var="item" items="${view.list}">
            <tr>
              <td>${item.materialName}</td>
              <td>${item.currentQuantity}</td>
              <td>${item.safetyQuantity}</td>
              <td>
                <c:url var="adjustUrl" value="/owner/inventories/${item.inventoryId}/adjust" />
                <a href="${adjustUrl}" class="btn btn-sm btn-outline-primary">조정</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <t:pagination pageInfo="${pageInfo}"></t:pagination>
    </t:menubarBO>
    <script>
      sessionStorage.setItem("inventoryListUrl", window.location.pathname + window.location.search);
      $(() => {
        $("#material-type-option").on("change", () => $("form").submit());
        $("#below-safety-checkbox").on("change", () => $("form").submit());
      });
    </script>
  </body>
</html>
