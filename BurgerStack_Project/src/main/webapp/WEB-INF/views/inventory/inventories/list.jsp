<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<c:set var="isAdmin" value="${sessionScope.loginUser.admin}" />
<c:set var="isOwner" value="${sessionScope.loginUser.owner}" />
<c:set var="role" value="${isAdmin ? 'admin' : 'owner'}" />
<c:url var="inventoryListUrl" value="/${role}/inventories" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>재고 목록</title>
    <style></style>
  </head>
  <body>
    <t:layout>
      <div class="outer">
        <div class="d-flex justify-content-between mb-3">
          <h2>재고 목록</h2>
          <button class="btn btn-secondary" onclick="location.href = ${inventoryListUrl}">초기화</button>
        </div>
        <form class="d-flex justify-content-between mb-3 text-nowrap" action="${inventoryListUrl}" method="get">
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

          <select id="material-type-option" name="materialType" class="form-control mr-3">
            <option value="">유형 선택</option>
            <option value="AF" ${view.condition.materialType eq 'AF' ? 'selected' : ''}>상온식품</option>
            <option value="RF" ${view.condition.materialType eq 'RF' ? 'selected' : ''}>냉장식품</option>
            <option value="FF" ${view.condition.materialType eq 'FF' ? 'selected' : ''}>냉동식품</option>
            <option value="PK" ${view.condition.materialType eq 'PK' ? 'selected' : ''}>포장재</option>
            <option value="KW" ${view.condition.materialType eq 'KW' ? 'selected' : ''}>주방용품</option>
            <option value="ET" ${view.condition.materialType eq 'ET' ? 'selected' : ''}>기타</option>
          </select>

          <div class="form-check mr-3">
            <input class="form-check-input" type="checkbox" name="belowSafetyStock" value="true" id="below-safety-checkbox" ${view.condition.belowSafetyStock eq true ? 'checked' : ''} />
            <label class="form-check-label" for="below-safety-checkbox">안전재고 미만</label>
          </div>
          <input type="text" id="material-name-input" name="materialName" class="form-control mr-3" placeholder="검색할 자재명을 입력하세요." value="${view.condition.materialName}" />
          <button type="submit" class="btn btn-primary">검색</button>
        </form>
        <table:DataTable>
          <jsp:attribute name="thead">
            <tr>
              <c:if test="${isAdmin}"><th>점포명</th></c:if>
              <th>자재명</th>
              <th>현재 수량</th>
              <th>안전재고 수량</th>
              <c:if test="${isOwner}"><th>안전재고 조정</th></c:if>
              <th>조정</th>
            </tr>
          </jsp:attribute>
          <jsp:attribute name="tbody">
            <c:forEach var="item" items="${view.list}">
              <c:url var="adjustUrl" value="/${role}/inventories/${item.inventoryId}/adjust" />
              <c:url var="editUrl" value="/owner/inventories/${item.inventoryId}/edit" />
              <table:TableRow>
                <c:if test="${isAdmin}"><table:TextCell value="${item.storeName}" /></c:if>
                <table:TextCell value="${item.materialName}" />
                <table:NumberCell value="${item.currentQuantity}" />
                <table:NumberCell value="${item.safetyQuantity}" />
                <c:if test="${isOwner}"><table:ActionCell href="${editUrl}">안전재고 조정</table:ActionCell></c:if>
                <table:ActionCell href="${adjustUrl}">조정</table:ActionCell>
              </table:TableRow>
            </c:forEach>
          </jsp:attribute>
        </table:DataTable>
        <t:pagination pageInfo="${view.pageInfo}" />
      </div>
    </t:layout>
    <script>
      sessionStorage.setItem("inventoryListUrl", window.location.pathname + window.location.search);
      $(() => {
        $("#store-option").on("change", () => $("form").submit());
        $("#material-type-option").on("change", () => $("form").submit());
        $("#below-safety-checkbox").on("change", () => $("form").submit());
      });
    </script>
  </body>
</html>
