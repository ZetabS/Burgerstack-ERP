<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
  <c:when test="${value eq 'OPEN'}">영업중</c:when>
  <c:when test="${value eq 'CLOSED'}">폐점</c:when>
  <c:otherwise><c:out value="${value}" /></c:otherwise>
</c:choose>
