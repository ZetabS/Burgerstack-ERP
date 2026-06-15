<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="description" required="false" type="java.lang.String" %>
<%@ attribute name="actions" fragment="true" required="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="ds-page-header d-flex justify-content-between align-items-start mb-3">
  <div>
    <h1 class="h3 font-weight-bold mb-0"><c:out value="${title}" /></h1>
    <c:if test="${not empty description}">
      <p class="text-muted mb-0 mt-1"><c:out value="${description}" /></p>
    </c:if>
  </div>
  <c:if test="${not empty actions}">
    <div class="d-flex justify-content-end">
      <jsp:invoke fragment="actions" />
    </div>
  </c:if>
</div>
