<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

<c:set var="variant" value="secondary" />
<c:choose>
  <c:when test="${value eq 'DIFFERENCE'}">
    <c:set var="variant" value="warning" />
  </c:when>
  <c:when test="${value eq 'NORMAL'}">
    <c:set var="variant" value="primary" />
  </c:when>
</c:choose>

<span class="badge badge-${variant}">
  <display:ReceiptStatusLabel value="${value}" />
</span>
