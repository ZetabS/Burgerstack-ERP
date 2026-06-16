<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="value" required="false" type="java.lang.Object" %>
<%@ attribute name="align" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<td class="ds-table__col-fit text-${empty align ? 'center' : align}">
  <c:choose>
    <c:when test="${not empty value}">
      <c:out value="${value}" />
    </c:when>
    <c:otherwise>
      <jsp:doBody />
    </c:otherwise>
  </c:choose>
</td>
