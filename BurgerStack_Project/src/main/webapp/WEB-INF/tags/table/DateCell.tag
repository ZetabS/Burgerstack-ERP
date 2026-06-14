<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.time.LocalDate" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="datetime" uri="/WEB-INF/tld/datetime.tld" %>

<td class="data-table__col-fit text-right">
  <c:out value="${datetime:formatDate(value)}" />
</td>
