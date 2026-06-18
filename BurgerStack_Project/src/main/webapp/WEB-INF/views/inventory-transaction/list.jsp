<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>
<c:set var="isAdmin" value="${sessionScope.loginUser.admin}" />
<c:set var="role" value="${isAdmin ? 'admin' : 'owner'}" />
<c:url var="baseUrl" value="/${role}/inventory-transactions" />

<t:layout>
  <layout:ListPage title="재고 변동 이력">
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
                  <option value="${option.storeId}" ${option.storeId eq view.condition.storeId ? 'selected' : ''}><c:out value="${option.storeName}" /></option>
                </c:forEach>
              </select>
            </c:if>

            <select name="transactionType" class="form-control js-submit-on-change">
              <option value="">유형 선택</option>
              <c:forEach var="type" items="RECEIPT,STORE_CLOSING,ADJUSTMENT">
                <option value="${type}" ${view.condition.transactionType eq type ? 'selected' : ''}>
                  <display:InventoryTransactionTypeLabel value="${type}" />
                </option>
              </c:forEach>
            </select>
          </jsp:attribute>
          <jsp:attribute name="right">
            <common:DateRangeFilter startValue="${view.condition.startDate}" endValue="${view.condition.endDate}" autoSubmit="true" />
          </jsp:attribute>
        </layout:Toolbar>
      </form>
    </jsp:attribute>

    <jsp:attribute name="table">
      <table:Table isEmpty="${empty view.list}" emptyMessage="재고 변동 이력이 없습니다.">
        <jsp:attribute name="thead">
          <tr>
            <th>변동 이력 코드</th>
            <c:if test="${isAdmin}"><th>점포명</th></c:if>
            <th>변동 유형</th>
            <th>처리자</th>
            <th class="text-right">처리 일시</th>
            <th>사유</th>
          </tr>
        </jsp:attribute>
        <jsp:attribute name="tbody">
          <c:forEach var="item" items="${view.list}">
            <c:url var="detail" value="/${role}/inventory-transactions/${item.inventoryTransactionId}" />
            <table:TableRow clickable="true" href="${detail}">
              <table:TextFitCell value="${item.inventoryTransactionCode}" />
              <c:if test="${isAdmin}"><table:TextFitCell value="${item.storeName}" /></c:if>
              <table:FitCell>
                <display:InventoryTransactionTypeBadge value="${item.transactionType}" />
              </table:FitCell>
              <table:TextFitCell value="${item.createdByName}" />
              <table:DateTimeCell value="${item.createdAt}" />
              <table:TextCell value="${item.reason}" />
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
