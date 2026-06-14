<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
  <c:when test="${value eq 'DIFFERENCE'}">차이 있음</c:when>
  <c:when test="${value eq 'NORMAL'}">정상</c:when>
  <c:otherwise><c:out value="${value}" /></c:otherwise>
</c:choose>
