<!-- 
      사용법
      <title>...</title>
      <jsp:include page="../common/header.jsp" /> 복사 후 title 태그 밑에 붙이기
-->

<!-- title 비어있을시 자동 삽입 -->
<title>${empty title ? 'BurgerStack ERP' : title}</title>
<meta charset="UTF-8">

<!-- 타이틀 버거스택 로고 -->
<link rel="shortcut icon"
      type="image/x-icon"
      href="${pageContext.request.contextPath}/resources/images/BS_logo2.png" />
<!-- 공통 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

<!-- alertify  -->
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css">

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css">

<script src="https://cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>