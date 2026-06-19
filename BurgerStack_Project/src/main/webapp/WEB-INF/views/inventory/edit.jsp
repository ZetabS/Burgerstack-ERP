<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<c:url var="baseUrl" value="/owner/inventories" />
<c:url var="editAction" value="/owner/inventories/${view.inventoryId}" />

<t:layout>
  <layout:Page title="안전재고 조정">
    <jsp:attribute name="actions">
      <common:ReturnLink href="${baseUrl}">목록으로</common:ReturnLink>
    </jsp:attribute>

    <jsp:body>
      <form action="${editAction}" method="post">
        <layout:Section title="기본 정보">
          <common:FieldList>
            <layout:FieldRow label="자재명"><c:out value="${view.materialName}" /></layout:FieldRow>
            <layout:FieldRow label="현재 수량"><c:out value="${view.currentQuantity}" /></layout:FieldRow>
            <layout:FieldRow label="안전재고 수량"><c:out value="${view.safetyQuantity}" /></layout:FieldRow>
          </common:FieldList>
        </layout:Section>

        <layout:Section title="안전재고 입력">
          <layout:FieldRow label="안전재고 수량" inputId="safetyQuantity">
            <input type="number" class="form-control" id="safetyQuantity" name="safetyQuantity" value="${view.safetyQuantity}" min="0" required />
          </layout:FieldRow>
        </layout:Section>

        <common:Actions>
          <common:ReturnLink href="${baseUrl}">목록으로</common:ReturnLink>
          <button type="submit" class="btn btn-primary">저장</button>
        </common:Actions>
      </form>
    </jsp:body>
  </layout:Page>
</t:layout>
