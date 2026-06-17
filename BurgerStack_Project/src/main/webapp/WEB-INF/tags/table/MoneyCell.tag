<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.Number" %>
<%@ attribute name="suffix" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<td class="ds-numeric ds-table__col-fit text-right">
  <c:if test="${not empty value}"><fmt:formatNumber value="${value}" pattern="#,###" /><c:out value="${suffix}" /></c:if>
</td>
