<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="datetime" uri="/WEB-INF/tld/datetime.tld" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>
<c:set var="isAdmin" value="${sessionScope.loginUser.admin}" />
<c:set var="role" value="${isAdmin ? 'admin' : 'owner'}" />
<c:url var="listReturnUrl" value="/${role}/inventory-transactions" />

<t:layout>
  <layout:Page title="재고 변동 상세">
    <jsp:attribute name="actions">
      <common:ReturnLink href="${listReturnUrl}">목록으로</common:ReturnLink>
    </jsp:attribute>

    <jsp:body>
      <layout:Section title="기본 정보">
        <common:FieldList>
          <layout:FieldRow label="변동 코드">${detail.inventoryTransactionCode}</layout:FieldRow>
          <c:if test="${isAdmin}">
            <layout:FieldRow label="점포명">${detail.storeName}</layout:FieldRow>
          </c:if>
          <layout:FieldRow label="변동 유형">
            <display:InventoryTransactionTypeLabel value="${detail.transactionType}" />
          </layout:FieldRow>
          <layout:FieldRow label="처리자">${detail.createdByName}</layout:FieldRow>
          <layout:FieldRow label="처리 일시">
            <c:out value="${datetime:formatDateTime(detail.createdAt)}" />
          </layout:FieldRow>
          <layout:FieldRow label="사유">${detail.reason}</layout:FieldRow>
          <layout:FieldRow label="비고">
            <c:choose>
              <c:when test="${empty detail.transactionMemo}">
                <span class="text-muted">-</span>
              </c:when>
              <c:otherwise>
                <c:out value="${detail.transactionMemo}" />
              </c:otherwise>
            </c:choose>
          </layout:FieldRow>
        </common:FieldList>
      </layout:Section>

      <layout:TableSection title="변동 품목">
        <table:Table>
          <jsp:attribute name="thead">
            <tr>
              <th>자재 코드</th>
              <th>자재명</th>
              <th>자재 유형</th>
              <th class="text-right">변동 전 수량</th>
              <th>변동 수량</th>
              <th>변동 후 수량</th>
            </tr>
          </jsp:attribute>
          <jsp:attribute name="tbody">
            <c:forEach var="item" items="${detail.list}">
              <table:TableRow>
                <table:TextFitCell value="${item.materialCode}" />
                <table:TextCell value="${item.materialName}" />
                <table:FitCell>
                  <display:MaterialTypeLabel value="${item.materialType}" />
                </table:FitCell>
                <table:NumberCell value="${item.beforeQuantity}" />
                <table:DeltaCell value="${item.changedQuantity}" />
                <table:NumberCell value="${item.afterQuantity}" />
              </table:TableRow>
            </c:forEach>
          </jsp:attribute>
        </table:Table>
      </layout:TableSection>

      <common:Actions>
        <common:ReturnLink href="${listReturnUrl}">목록으로</common:ReturnLink>
      </common:Actions>
    </jsp:body>
  </layout:Page>
</t:layout>
