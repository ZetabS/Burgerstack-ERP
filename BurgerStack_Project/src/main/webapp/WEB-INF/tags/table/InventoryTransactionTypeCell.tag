<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<c:choose>
  <c:when test="${value eq 'RECEIPT'}">
    <table:BadgeCell value="입고" variant="success" />
  </c:when>
  <c:when test="${value eq 'STORE_CLOSING'}">
    <table:BadgeCell value="마감" variant="warning" />
  </c:when>
  <c:when test="${value eq 'ADJUSTMENT'}">
    <table:BadgeCell value="조정" variant="secondary" />
  </c:when>
  <c:otherwise>
    <table:BadgeCell value="${value}" variant="secondary" />
  </c:otherwise>
</c:choose>
