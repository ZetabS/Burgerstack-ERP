<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="thead" fragment="true" required="true" %>
<%@ attribute name="tbody" fragment="true" required="true" %>

<div class="table-responsive">
  <table class="table data-table table-hover w-100 table-fixed">
    <thead>
      <jsp:invoke fragment="thead" />
    </thead>
    <tbody>
      <jsp:invoke fragment="tbody" />
    </tbody>
  </table>
</div>
