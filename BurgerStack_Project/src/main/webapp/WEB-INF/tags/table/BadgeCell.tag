<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.Object" %>
<%@ attribute name="variant" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<td class="data-table__col-fit">
  <span class="badge badge-${empty variant ? 'secondary' : variant}">
    <c:out value="${value}" />
  </span>
</td>
