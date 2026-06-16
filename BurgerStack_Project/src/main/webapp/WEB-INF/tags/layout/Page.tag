<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="description" required="false" type="java.lang.String" %>
<%@ attribute name="actions" fragment="true" required="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>

<div class="ds-page container">
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

  <jsp:doBody />
</div>
