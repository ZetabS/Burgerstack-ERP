<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- alertify 1.13.1 --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css" />
<script src="https://cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>

<c:if test="${ not empty sessionScope.alertMsg }">
  <span id="alert" hidden><c:out value="${alertMsg}" /></span>
  <script>
    $(() => {
      alertify.alert($("#alert").text(), () => {
        $("#alert").remove();
      });
    });
  </script>
  <c:remove var="alertMsg" scope="session" />
</c:if>
