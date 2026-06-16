<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="left" fragment="true" required="false" %>
<%@ attribute name="right" fragment="true" required="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="ds-toolbar d-flex justify-content-between align-items-center mb-3">
  <div class="ds-toolbar__left d-flex align-items-center">
    <c:if test="${not empty left}">
      <jsp:invoke fragment="left" />
    </c:if>
  </div>
  <div class="ds-toolbar__right ml-auto">
    <c:if test="${not empty right}">
      <jsp:invoke fragment="right" />
    </c:if>
  </div>
</div>
