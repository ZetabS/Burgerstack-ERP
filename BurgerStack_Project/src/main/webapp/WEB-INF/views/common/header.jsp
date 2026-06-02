<%-- 주입받은 title 변수를 여기에 적용 --%>
<title>${empty title ? 'BurgerStack ERP' : title}</title>
<meta charset="UTF-8">
<link rel="shortcut icon"
      type="image/x-icon"
      href="${pageContext.request.contextPath}/resources/images/BS_logo2.png" />