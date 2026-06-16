<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.Number" %>
<%@ attribute name="suffix" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<td class="ds-numeric ds-table__col-fit text-right">
  <c:choose>
    <c:when test="${value > 0}">
      <span class="text-success">+<c:out value="${value}" /><c:out value="${suffix}" /></span>
    </c:when>
    <c:when test="${value < 0}">
      <span class="text-danger"><c:out value="${value}" /><c:out value="${suffix}" /></span>
    </c:when>
    <c:otherwise>
      <span class="text-muted">0<c:out value="${suffix}" /></span>
    </c:otherwise>
  </c:choose>
</td>
