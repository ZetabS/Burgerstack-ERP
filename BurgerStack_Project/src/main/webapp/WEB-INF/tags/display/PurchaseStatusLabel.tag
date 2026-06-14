<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
  <c:when test="${value eq 'REQUESTED'}">요청중</c:when>
  <c:when test="${value eq 'PARTIALLY_APPROVED'}">부분승인</c:when>
  <c:when test="${value eq 'APPROVED'}">승인</c:when>
  <c:when test="${value eq 'CANCELED'}">발주취소</c:when>
  <c:when test="${value eq 'REJECTED'}">반려</c:when>
  <c:when test="${value eq 'RECEIVED'}">입고완료</c:when>
  <c:otherwise><c:out value="${value}" /></c:otherwise>
</c:choose>
