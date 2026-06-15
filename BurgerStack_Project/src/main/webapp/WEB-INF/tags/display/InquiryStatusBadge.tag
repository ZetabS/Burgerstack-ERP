<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

<c:set var="variant" value="secondary" />
<c:choose>
  <c:when test="${value eq 'REQUESTED'}">
    <c:set var="variant" value="warning" />
  </c:when>
  <c:when test="${value eq 'ANSWERED'}">
    <c:set var="variant" value="primary" />
  </c:when>
</c:choose>

<span class="ds-display-badge badge badge-${variant}">
  <display:InquiryStatusLabel value="${value}" />
</span>
