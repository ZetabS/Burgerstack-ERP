<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<span class="ds-display-label">
  <c:choose>
    <c:when test="${value eq 'REQUESTED'}">문의</c:when>
    <c:when test="${value eq 'ANSWERED'}">답변 완료</c:when>
    <c:otherwise><c:out value="${value}" /></c:otherwise>
  </c:choose>
</span>
