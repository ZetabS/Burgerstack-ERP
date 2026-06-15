<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="name" required="true" type="java.lang.String" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="placeholder" required="false" type="java.lang.String" %>
<%@ attribute name="buttonLabel" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="ds-search-bar input-group w-auto">
  <input type="text" name="${name}" class="form-control" placeholder="${placeholder}" value="${value}" />
  <div class="input-group-append">
    <button type="submit" class="btn btn-primary">
      <c:out value="${empty buttonLabel ? '검색' : buttonLabel}" />
    </button>
  </div>
</div>
