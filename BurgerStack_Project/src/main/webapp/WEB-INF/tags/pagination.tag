<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="uri" uri="/WEB-INF/tld/uri.tld" %>
<%@ attribute name="pageInfo" required="true" type="com.kh.burgerstack.common.pagination.PageInfo" %>

<%-- \
페이지네이션 태그입니다.

사용 방법:
```
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:pagination pageInfo="${pageInfo}" />
```
\ --%>

<nav aria-label="페이지네이션">
  <ul class="pagination justify-content-center js-pagination">
    <li class="page-item ${pageInfo.hasPrevious ? '' : 'disabled'}">
      <a class="page-link" href="${ uri:applyPagination(pageContext.request.queryString, pageInfo.previousPage, pageInfo.pageSize) }"> 이전 </a>
    </li>

    <c:forEach var="pageNo" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
      <li class="page-item ${pageNo eq pageInfo.currentPage ? 'active' : ''}">
        <a class="page-link" href="${ uri:applyPagination(pageContext.request.queryString, pageNo, pageInfo.pageSize) }"> ${pageNo} </a>
      </li>
    </c:forEach>

    <li class="page-item ${pageInfo.hasNext ? '' : 'disabled'}">
      <a class="page-link" href="${ uri:applyPagination(pageContext.request.queryString, pageInfo.nextPage, pageInfo.pageSize) }"> 다음 </a>
    </li>
  </ul>
</nav>
