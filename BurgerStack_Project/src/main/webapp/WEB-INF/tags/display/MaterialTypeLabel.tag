<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ attribute name="foodSuffix" required="false" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
  <c:when test="${value eq 'AF'}">상온식품<c:if test="${foodSuffix}">식품</c:if></c:when>
  <c:when test="${value eq 'RF'}">냉장식품<c:if test="${foodSuffix}">식품</c:if></c:when>
  <c:when test="${value eq 'FF'}">냉동식품<c:if test="${foodSuffix}">식품</c:if></c:when>
  <c:when test="${value eq 'PK'}">포장재</c:when>
  <c:when test="${value eq 'KW'}">주방용품</c:when>
  <c:when test="${value eq 'ET'}">기타</c:when>
  <c:when test="${empty value}">-</c:when>
  <c:otherwise><c:out value="${value}" /></c:otherwise>
</c:choose>
