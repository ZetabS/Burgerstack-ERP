<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<td class="data-table__col-fit">
  <c:choose>
    <c:when test="${not empty value}">
      <c:out value="${value}" />
    </c:when>
    <c:otherwise>
      <jsp:doBody />
    </c:otherwise>
  </c:choose>
</td>
