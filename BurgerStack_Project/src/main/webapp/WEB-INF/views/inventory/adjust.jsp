<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<c:set var="isAdmin" value="${sessionScope.loginUser.admin}" />
<c:set var="role" value="${isAdmin ? 'admin' : 'owner'}" />
<c:url var="baseUrl" value="/${role}/inventories" />
<c:url var="adjustAction" value="/${role}/inventories/${detail.inventoryId}/adjust" />

<t:layout>
  <layout:Page title="재고 조정">
    <jsp:attribute name="actions">
      <common:ReturnLink href="${baseUrl}">목록으로</common:ReturnLink>
    </jsp:attribute>

    <jsp:body>
      <form action="${adjustAction}" method="post">
        <layout:Section title="기본 정보">
          <common:FieldList>
            <c:if test="${isAdmin}">
              <layout:FieldRow label="점포명"><c:out value="${detail.storeName}" /></layout:FieldRow>
            </c:if>
            <layout:FieldRow label="자재명"><c:out value="${detail.materialName}" /></layout:FieldRow>
            <layout:FieldRow label="현재 수량"><c:out value="${detail.currentQuantity}" /></layout:FieldRow>
            <layout:FieldRow label="안전재고 수량"><c:out value="${detail.safetyQuantity}" /></layout:FieldRow>
          </common:FieldList>
        </layout:Section>

        <layout:Section title="조정 입력">
          <layout:FieldRow label="조정 후 수량" inputId="afterQuantity">
            <input type="number" class="form-control" id="afterQuantity" name="afterQuantity" value="${detail.currentQuantity}" min="0" max="1000" required />
          </layout:FieldRow>

          <layout:FieldRow label="사유" inputId="reason">
            <input type="text" class="form-control" id="reason" name="reason" placeholder="예: 실사 오차, 폐기, 입고 누락" required />
          </layout:FieldRow>

          <layout:FieldRow label="비고" inputId="transactionMemo" help="추가 설명이 필요한 경우 입력하세요.">
            <textarea class="form-control" id="transactionMemo" name="transactionMemo" rows="5"></textarea>
          </layout:FieldRow>
        </layout:Section>

        <common:Actions>
          <common:ReturnLink href="${baseUrl}">목록으로</common:ReturnLink>
          <button type="submit" class="btn btn-primary">조정</button>
        </common:Actions>
      </form>
    </jsp:body>
  </layout:Page>
</t:layout>
