<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

<c:set var="isAdmin" value="${sessionScope.loginUser.admin}" />
<c:set var="isOwner" value="${sessionScope.loginUser.owner}" />
<c:set var="role" value="${isAdmin ? 'admin' : 'owner'}" />
<c:url var="baseUrl" value="/${role}/inventories" />

<t:layout>
  <layout:ListPage title="재고 목록">
    <jsp:attribute name="actions">
      <a href="${baseUrl}" class="btn btn-secondary">초기화</a>
    </jsp:attribute>

    <jsp:attribute name="toolbar">
      <form action="${baseUrl}" method="get">
        <input type="hidden" name="page" value="1" />
        <input type="hidden" name="size" value="${view.pageInfo.size}" />
        <layout:Toolbar>
          <jsp:attribute name="left">
            <c:if test="${isAdmin}">
              <select name="storeId" class="form-control mr-2 js-submit-on-change">
                <option value="">전체 점포</option>
                <c:forEach var="option" items="${view.storeOptions}">
                  <option value="${option.storeId}" ${option.storeId eq view.condition.storeId ? 'selected' : ''}>${option.storeName}</option>
                </c:forEach>
              </select>
            </c:if>

            <select name="materialType" class="form-control mr-2 js-submit-on-change">
              <option value="">전체 유형</option>
              <c:forEach var="type" items="AF,RF,FF,PK,KW,ET">
                <option value="${type}" ${view.condition.materialType eq type ? 'selected' : ''}>
                  <display:MaterialTypeLabel value="${type}" />
                </option>
              </c:forEach>
            </select>

            <div class="form-check ds-toolbar-checkbox">
              <input class="form-check-input js-submit-on-change" type="checkbox" name="belowSafetyStock" value="true" id="below-safety-checkbox" ${view.condition.belowSafetyStock eq true ? 'checked' : ''} />
              <label class="form-check-label" for="below-safety-checkbox">안전재고 미만</label>
            </div>
          </jsp:attribute>
          <jsp:attribute name="right">
            <common:SearchBar name="materialName" value="${view.condition.materialName}" placeholder="자재명 검색" />
          </jsp:attribute>
        </layout:Toolbar>
      </form>
    </jsp:attribute>

    <jsp:attribute name="table">
      <table:Table isEmpty="${empty view.list}" emptyMessage="조회된 재고가 없습니다.">
        <jsp:attribute name="thead">
          <tr>
            <c:if test="${isAdmin}"><th>점포명</th></c:if>
            <th>자재 코드</th>
            <th>자재명</th>
            <th>자재 유형</th>
            <th class="text-right">현재 수량</th>
            <th class="text-right">안전재고 수량</th>
            <c:if test="${isOwner}"><th>안전재고 조정</th></c:if>
            <th class="text-center">조정</th>
          </tr>
        </jsp:attribute>
        <jsp:attribute name="tbody">
          <c:forEach var="item" items="${view.list}">
            <c:url var="adjustUrl" value="/${role}/inventories/${item.inventoryId}/adjust" />
            <c:url var="editUrl" value="/owner/inventories/${item.inventoryId}/edit" />
            <table:TableRow>
              <c:if test="${isAdmin}"><table:TextFitCell value="${item.storeName}" /></c:if>
              <table:TextFitCell value="${item.materialCode}" />
              <table:TextCell value="${item.materialName}" />
              <table:FitCell>
                <display:MaterialTypeLabel value="${item.materialType}" />
              </table:FitCell>
              <table:NumberCell value="${item.currentQuantity}" />
              <table:NumberCell value="${item.safetyQuantity}" />
              <c:if test="${isOwner}"><table:ActionLinkCell href="${editUrl}">안전재고 조정</table:ActionLinkCell></c:if>
              <table:ActionLinkCell href="${adjustUrl}">조정</table:ActionLinkCell>
            </table:TableRow>
          </c:forEach>
        </jsp:attribute>
      </table:Table>
    </jsp:attribute>

    <jsp:attribute name="pagination">
      <t:pagination pageInfo="${view.pageInfo}" />
    </jsp:attribute>
  </layout:ListPage>
</t:layout>
