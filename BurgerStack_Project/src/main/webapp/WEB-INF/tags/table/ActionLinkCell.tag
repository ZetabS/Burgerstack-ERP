<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="href" required="true" type="java.lang.String" %>

<td class="ds-table__col-fit text-center">
  <a href="${href}" class="btn btn-sm btn-outline-primary">
    <jsp:doBody />
  </a>
</td>
