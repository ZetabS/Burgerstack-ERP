<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<span class="ds-display-label">
  <c:choose>
    <c:when test="${value eq 'RECEIPT'}">입고</c:when>
    <c:when test="${value eq 'STORE_CLOSING'}">마감</c:when>
    <c:when test="${value eq 'ADJUSTMENT'}">조정</c:when>
    <c:otherwise><c:out value="${value}" /></c:otherwise>
  </c:choose>
</span>
