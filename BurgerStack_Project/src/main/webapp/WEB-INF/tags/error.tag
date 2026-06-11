<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="statusCode" required="true" type="java.lang.String" %>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="defaultMessage" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:layout>
  <div class="card shadow-sm">
    <div class="card-body text-center py-5">
      <h1 class="display-4 font-weight-bold mb-3">
        <c:out value="${statusCode}" />
      </h1>

      <h2 class="h4 mb-3">
        <c:out value="${title}" />
      </h2>

      <p class="text-muted mb-4">
        <c:choose>
          <c:when test="${not empty message}">
            <c:out value="${message}" />
          </c:when>
          <c:otherwise>
            <c:out value="${defaultMessage}" />
          </c:otherwise>
        </c:choose>
      </p>

      <div class="d-flex justify-content-center">
        <a href="javascript:history.back()" class="btn btn-outline-secondary mr-2"> 이전 페이지 </a>

        <a href="${pageContext.request.contextPath}/" class="btn btn-primary"> 홈으로 이동 </a>
      </div>
    </div>
  </div>
</t:layout>
