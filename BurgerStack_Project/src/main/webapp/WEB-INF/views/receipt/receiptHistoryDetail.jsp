<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<c:url var="listUrl" value="/owner/receipts" />
<c:url var="purchaseUrl" value="/owner/purchases/${receipt.purchaseOrderId}" />

<t:layout>
  <layout:Page title="입고 이력 상세" description="입고 기본 정보와 품목별 상세 내역을 확인할 수 있습니다.">

    <jsp:attribute name="actions">
      <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>
    </jsp:attribute>

    <jsp:body>

      <layout:Section title="입고 기본 정보">

        <layout:FieldRow label="입고 코드">
          <c:choose>
            <c:when test="${not empty receipt.receiptCode}">
              ${receipt.receiptCode}
            </c:when>
            <c:otherwise>
              R${receipt.receiptId}
            </c:otherwise>
          </c:choose>
        </layout:FieldRow>

        <layout:FieldRow label="발주 코드">
          <a href="${purchaseUrl}">
            <c:choose>
              <c:when test="${not empty receipt.purchaseCode}">
                ${receipt.purchaseCode}
              </c:when>
              <c:otherwise>
                P${receipt.purchaseOrderId}
              </c:otherwise>
            </c:choose>
          </a>
        </layout:FieldRow>

        <layout:FieldRow label="입고 상태">
          <c:choose>
            <c:when test="${receipt.receiptStatus eq 'DIFFERENCE'}">
              <span class="badge badge-warning">차이 있음</span>
            </c:when>
            <c:otherwise>
              <span class="badge badge-success">정상 입고</span>
            </c:otherwise>
          </c:choose>
        </layout:FieldRow>

        <layout:FieldRow label="입고 완료일시">
          <c:choose>
            <c:when test="${not empty receipt.receivedAt}">
              ${receipt.receivedAt.toString().replace('T', ' ')}
            </c:when>
            <c:otherwise>
              <span class="text-muted">-</span>
            </c:otherwise>
          </c:choose>
        </layout:FieldRow>

      </layout:Section>

      <layout:TableSection title="상세 품목" description="입고 처리된 품목별 수량과 금액을 확인합니다.">

        <table:Table isEmpty="${empty itemList}" emptyMessage="입고 상세 내역이 없습니다.">

          <jsp:attribute name="thead">
            <tr>
              <th>자재 코드</th>
              <th>자재명</th>
              <th class="text-center">자재 유형</th>
              <th class="text-right">단가</th>
              <th class="text-right">승인 수량</th>
              <th class="text-right">요청 수량</th>
              <th class="text-right">실입고 수량</th>
              <th class="text-right">차이 수량</th>
              <th>사유</th>
              <th class="text-right">금액</th>
            </tr>
          </jsp:attribute>

          <jsp:attribute name="tbody">
            <c:set var="totalPrice" value="0" />

            <c:forEach var="item" items="${itemList}">
              <table:TableRow>

                <table:TextFitCell value="${item.materialCode}" />

                <table:TextCell value="${item.materialName}" />

                <table:FitCell>
                  <c:choose>
                    <c:when test="${item.materialType eq 'AF'}">상온</c:when>
                    <c:when test="${item.materialType eq 'RF'}">냉장</c:when>
                    <c:when test="${item.materialType eq 'FF'}">냉동</c:when>
                    <c:when test="${item.materialType eq 'PK'}">포장재</c:when>
                    <c:when test="${item.materialType eq 'KW'}">주방용품</c:when>
                    <c:otherwise>${item.materialType}</c:otherwise>
                  </c:choose>
                </table:FitCell>

                <table:MoneyCell value="${item.supplyPrice}" suffix="원" />

                <table:NumberCell value="${item.approvedQuantity}" />

                <table:NumberCell value="${item.requestQuantity}" />

                <table:NumberCell value="${item.receivedQuantity}" />

                <table:DeltaCell value="${item.defectQuantity}" />

                <table:TextCell value="${empty item.receiptItemMemo ? '-' : item.receiptItemMemo}" />

                <table:MoneyCell value="${item.amount}" suffix="원" />

              </table:TableRow>

              <c:set var="totalPrice" value="${totalPrice + item.amount}" />
            </c:forEach>

            <c:if test="${not empty itemList}">
              <tr class="font-weight-bold">
                <td colspan="9" class="text-right">총 금액</td>
                <td class="text-right">
                  <span class="font-weight-bold">
                    <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원
                  </span>
                </td>
              </tr>
            </c:if>
          </jsp:attribute>

        </table:Table>

      </layout:TableSection>

      <layout:Section title="비고">
        <layout:FieldRow label="입고 메모">
          <c:choose>
            <c:when test="${empty receipt.receiptMemo}">
              <span class="text-muted">-</span>
            </c:when>
            <c:otherwise>
              ${receipt.receiptMemo}
            </c:otherwise>
          </c:choose>
        </layout:FieldRow>
      </layout:Section>

      <common:Actions>
        <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>
      </common:Actions>

    </jsp:body>

  </layout:Page>
</t:layout>