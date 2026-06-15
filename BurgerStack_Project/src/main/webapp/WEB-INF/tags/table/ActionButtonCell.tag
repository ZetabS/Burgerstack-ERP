<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="onclick" required="true" type="java.lang.String" %>

<td class="ds-table__col-fit text-center">
  <button type="button" class="btn btn-sm btn-outline-primary" onclick="${onclick}">
    <jsp:doBody />
  </button>
</td>
