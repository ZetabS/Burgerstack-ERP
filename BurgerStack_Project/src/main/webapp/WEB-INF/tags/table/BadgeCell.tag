<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="variant" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<td class="data-table__col-fit text-center">
  <span class="badge badge-${empty variant ? 'secondary' : variant}">
    <jsp:doBody />
  </span>
</td>
