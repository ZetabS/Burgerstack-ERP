<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.Number" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<td class="ds-numeric ds-table__col-fit text-right">
  <c:out value="${value}" />
</td>
