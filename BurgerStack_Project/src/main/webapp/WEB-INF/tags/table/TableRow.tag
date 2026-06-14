<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="clickable" required="false" type="java.lang.Boolean" %>
<%@ attribute name="href" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
  <c:when test="${clickable and not empty href}">
    <tr data-clickable data-href="${href}">
      <jsp:doBody />
    </tr>
  </c:when>
  <c:otherwise>
    <tr>
      <jsp:doBody />
    </tr>
  </c:otherwise>
</c:choose>
