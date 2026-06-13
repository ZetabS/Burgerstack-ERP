<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="headerTitle" required="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>



<c:set var="role" value="${sessionScope.loginUser.admin ? 'admin' : sessionScope.loginUser.owner ? 'owner' : null}" />

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <%-- title 비어있을시 자동 삽입 --%>
    <title>${empty title ? 'BurgerStack ERP' : title}</title>

    <%-- 타이틀 버거스택 로고 --%>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/BS_logo2.png" />

    <%-- jQuery 3.7.1 --%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <%-- Bootstrap 4.6.2 --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <%-- CSS --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" />
  </head>
  <body>
    <div class="layout__container">
      <%-- 로고 --%>
      <c:url var="dashboardUrl" value="/${role}/dashboard" />
      <a class="layout__logo" href="${dashboardUrl}">
        <img class="layout__logo-img" src="${pageContext.request.contextPath}/resources/images/BS_logo2.png" alt="logo" />
        <span class="layout__logo-text">BurgerStack</span>
      </a>
      <%-- 헤더 --%>
      <div class="layout__header">
        <a href="" class="layout__header-title">${headerTitle}</a>
        <div class="layout__header-user-info">
          <span class="layout__header-user-info-text">${sessionScope.loginUser.userId}님 환영합니다.</span>
          <c:url var="logoutUrl" value="/auth/logout" />
          <a class="btn btn-burgerstack" href="${logoutUrl}">
            <span class="layout__header-user-info-text">로그아웃</span>
          </a>
        </div>
      </div>

      <%-- 메뉴바 --%>
      <div class="layout__menubar">
        <div class="layout__menubar-profile-box">
          <div>
            <span class="layout__menubar-profile-name">${sessionScope.loginUser.userName}</span>
            <c:url var="mypageUrl" value="/${role}/mypage" />
            <a class="layout__menubar-profile-role" href="${mypageUrl}">마이페이지</a>
          </div>
          <div class="layout__menubar-profile-role">
            <if test="${role == 'owner'}">
              ${sessionScope.loginUser.storeName}
            </if>
            ${role == 'owner' ? '점주' : '총괄 관리자'}
          </div>
        </div>
        <c:choose>
          <c:when test="${sessionScope.loginUser.owner}">
            <t:menuBO />
          </c:when>
          <c:when test="${sessionScope.loginUser.admin}">
            <t:menuHO />
          </c:when>
        </c:choose>
      </div>

      <%-- CONTENT --%>
      <div class="layout__main">
        <jsp:doBody />
      </div>
    </div>
    <t:alertify />
  </body>
</html>
