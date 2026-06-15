<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.time.LocalDateTime" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="datetime" uri="/WEB-INF/tld/datetime.tld" %>

<td class="ds-numeric ds-table__col-fit text-right">
  <c:out value="${datetime:formatDateTime(value)}" />
</td>
