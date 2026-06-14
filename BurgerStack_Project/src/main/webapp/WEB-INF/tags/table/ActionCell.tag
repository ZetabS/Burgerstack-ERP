<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="href" required="false" type="java.lang.String" %>
<%@ attribute name="onclick" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<td class="data-table__col-fit text-center">
  <c:choose>
    <c:when test="${not empty href}">
      <a href="${href}" class="btn btn-sm btn-outline-primary">
        <jsp:doBody />
      </a>
    </c:when>
    <c:otherwise>
      <button type="button" class="btn btn-sm btn-outline-primary" onclick="${onclick}">
        <jsp:doBody />
      </button>
    </c:otherwise>
  </c:choose>
</td>
