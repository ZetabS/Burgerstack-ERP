<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="href" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<a class="ds-return-link btn btn-secondary js-return-link" href="${href}">
  <jsp:doBody />
</a>
