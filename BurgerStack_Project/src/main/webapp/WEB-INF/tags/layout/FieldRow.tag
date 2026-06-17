<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="label" required="true" type="java.lang.String" %>
<%@ attribute name="inputId" required="false" type="java.lang.String" %>
<%@ attribute name="help" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="ds-field-row row">
  <c:choose>
    <c:when test="${not empty inputId}">
      <label class="col-sm-2 col-form-label font-weight-bold" for="${inputId}">
        <c:out value="${label}" />
      </label>
    </c:when>
    <c:otherwise>
      <div class="col-sm-2 font-weight-bold">
        <c:out value="${label}" />
      </div>
    </c:otherwise>
  </c:choose>
  <div class="col-sm-10">
    <jsp:doBody />
    <c:if test="${not empty help}">
      <small class="form-text text-muted"><c:out value="${help}" /></small>
    </c:if>
  </div>
</div>
