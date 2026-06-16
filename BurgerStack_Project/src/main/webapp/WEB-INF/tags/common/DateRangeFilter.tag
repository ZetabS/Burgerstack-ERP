<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" %>
<%@ attribute name="startName" required="false" type="java.lang.String" %>
<%@ attribute name="startValue" required="false" type="java.lang.String" %>
<%@ attribute name="endName" required="false" type="java.lang.String" %>
<%@ attribute name="endValue" required="false" type="java.lang.String" %>
<%@ attribute name="autoSubmit" required="false" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="js-date-range-filter d-flex align-items-center mr-2">
  <input
      type="date"
      name="${empty startName ? 'startDate' : startName}"
      class="js-date-range-filter-start form-control mr-2${autoSubmit eq true ? ' js-submit-on-change' : ''}"
      value="${startValue}"
      style="width: 150px;" />
  <span class="mx-2 text-muted">~</span>
  <input
      type="date"
      name="${empty endName ? 'endDate' : endName}"
      class="js-date-range-filter-end form-control mr-2${autoSubmit eq true ? ' js-submit-on-change' : ''}"
      value="${endValue}"
      style="width: 150px;" />
</div>
