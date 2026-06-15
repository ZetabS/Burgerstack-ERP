<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="title" required="false" type="java.lang.String" %>
<%@ attribute name="description" required="false" type="java.lang.String" %>
<%@ attribute name="actions" fragment="true" required="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<section class="ds-table-section card mb-3">
  <c:if test="${not empty title or not empty description or not empty actions}">
    <div class="card-header d-flex justify-content-between align-items-center">
      <div>
        <c:if test="${not empty title}">
          <h2 class="h6 font-weight-bold mb-0"><c:out value="${title}" /></h2>
        </c:if>
        <c:if test="${not empty description}">
          <p class="small text-muted mb-0 mt-1"><c:out value="${description}" /></p>
        </c:if>
      </div>
      <c:if test="${not empty actions}">
        <div>
          <jsp:invoke fragment="actions" />
        </div>
      </c:if>
    </div>
  </c:if>
  <div class="card-body">
    <jsp:doBody />
  </div>
</section>
