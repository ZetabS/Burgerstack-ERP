<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

<c:set var="variant" value="secondary" />
<c:choose>
  <c:when test="${value eq 'REQUESTED'}">
    <c:set var="variant" value="warning" />
  </c:when>
  <c:when test="${value eq 'APPROVED'}">
    <c:set var="variant" value="primary" />
  </c:when>
  <c:when test="${value eq 'REJECTED'}">
    <c:set var="variant" value="danger" />
  </c:when>
  <c:when test="${value eq 'RECEIVED'}">
    <c:set var="variant" value="primary" />
  </c:when>
</c:choose>

<span class="ds-display-badge badge badge-${variant}">
  <display:ReceiptStatusLabel value="${value}" />
</span>
