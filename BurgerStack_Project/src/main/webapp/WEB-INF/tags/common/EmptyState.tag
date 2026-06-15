<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="message" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="ds-empty-state text-center text-muted py-5">
  <c:out value="${empty message ? '조회된 정보가 없습니다.' : message}" />
</div>
