<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="description" required="false" type="java.lang.String" %>
<%@ attribute name="actions" fragment="true" required="false" %>
<%@ attribute name="toolbar" fragment="true" required="false" %>
<%@ attribute name="table" fragment="true" required="true" %>
<%@ attribute name="pagination" fragment="true" required="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>

<div class="ds-list-page container js-store-current-url">
  <c:choose>
    <c:when test="${not empty actions}">
      <layout:PageHeader title="${title}" description="${description}">
        <jsp:attribute name="actions">
          <jsp:invoke fragment="actions" />
        </jsp:attribute>
      </layout:PageHeader>
    </c:when>
    <c:otherwise>
      <layout:PageHeader title="${title}" description="${description}" />
    </c:otherwise>
  </c:choose>

  <section class="card mb-3">
    <div class="card-body pb-0">
      <c:if test="${not empty toolbar}">
        <jsp:invoke fragment="toolbar" />
      </c:if>
      <jsp:invoke fragment="table" />
      <c:if test="${not empty pagination}">
        <jsp:invoke fragment="pagination" />
      </c:if>
    </div>
  </section>
</div>
