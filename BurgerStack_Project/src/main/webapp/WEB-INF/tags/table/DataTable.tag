<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="thead" fragment="true" required="true" %>
<%@ attribute name="tbody" fragment="true" required="true" %>
<%@ attribute name="isEmpty" required="false" type="java.lang.Boolean" %>
<%@ attribute name="emptyMessage" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="table-responsive">
  <table class="table data-table table-hover w-100">
    <thead>
      <jsp:invoke fragment="thead" />
    </thead>
    <tbody>
      <c:choose>
        <c:when test="${isEmpty}">
          <tr>
            <td colspan="999" class="empty-row text-center">
              <c:out value="${empty emptyMessage ? '조회된 정보가 없습니다.' : emptyMessage}" />
            </td>
          </tr>
        </c:when>
        <c:otherwise>
          <jsp:invoke fragment="tbody" />
        </c:otherwise>
      </c:choose>
    </tbody>
  </table>
</div>
