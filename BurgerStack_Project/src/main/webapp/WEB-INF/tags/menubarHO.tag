<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="false" %>
<%@ tag body-content="scriptless" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>${empty title ? 'BurgerStack ERP' : title}</title>

<link rel="shortcut icon"
      type="image/x-icon"
      href="${pageContext.request.contextPath}/resources/images/BS_logo2.png" />

<!-- Bootstrap -->
<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    background-color:#f5f6fa;
    overflow:hidden;
    font-family:'Malgun Gothic';
}

.wrap{
    width:100%;
    height:100vh;
    display:flex;
    flex-direction:column;
}

/* 모든 하이퍼링크의 기본 스타일 제거 및 정렬 */
.link {
  display: inline-flex;    /* 내부 요소(이미지, 텍스트 등)를 가로로 일렬 정렬 */
  align-items: center;     /* 세로축 중앙 정렬 */
  text-decoration: none;   /* 밑줄 제거 */
  color: inherit;          /* 글자 색상이 파란색으로 변하지 않고 부모의 색상을 따름 */
}

/* 마우스를 올리거나 클릭했을 때도 스타일 유지 */
.link:hover, 
.link:focus, 
.link:active {
  text-decoration: none;
  color: inherit;
}

/* =========================
    HEADER
========================= */

.header{
    width:100%;
    height:70px;
    background:#222831;
    color:white;

    display:flex;
    align-items:center;
    justify-content:space-between;

    padding:0 30px;

    border-bottom:1px solid #393E46;
}

.header-left{
    display:flex;
    align-items:center;
    gap:15px;
}

/* 1. 하이퍼링크 스타일 초기화 및 가로 정렬 */
.brand-link {
  display: inline-flex;    /* 내부 요소들을 한 줄로 정렬 */
  align-items: center;     /* 이미지와 텍스트의 세로 중앙 맞춤 */
  text-decoration: none;   /* 하이퍼링크 밑줄 제거 */
  color: inherit;          /* 부모 요소의 글자 색상을 그대로 따라감 (또는 #ffffff 등 원하는 색상 지정) */
}

/* 2. 마우스를 올렸을 때도 스타일이 유지되도록 설정 (선택사항) */
.brand-link:hover, 
.brand-link:focus, 
.brand-link:active {
  text-decoration: none;
  color: inherit;
}

.logo{
    margin-right: 8px;       /* 로고 이미지 오른쪽에 약간의 공백 추가 */
    /* 필요하다면 이미지 크기 고정 */
    width: 32px; 
    height: 32px;
}

.system-title{
    font-size:20px;
    font-weight:600;
}

.header-right{
    display:flex;
    align-items:center;
    gap:20px;
    font-size:14px;
}

.logout-btn{
    border:none;
    background:#ff6b00;
    color:white;
    padding:8px 15px;
    border-radius:5px;
    cursor:pointer;
}

.logout-btn:hover{
    background:#e45f00;
}

/* =========================
    BODY
========================= */

.body-area{
    flex:1;
    display:flex;
    overflow:hidden;
}

/* =========================
    MENUBAR
========================= */

.menubar{
    width:250px;
    background:#2d3436;
    color:white;

    overflow-y:auto;
}

.profile-box{
    padding:25px 20px;
    border-bottom:1px solid #444;
}

.profile-name{
    font-size:18px;
    font-weight:600;
}

.profile-role{
    font-size:13px;
    color:#bbb;
    margin-top:5px;
}

.menu{
    padding-top:10px;
}

/* 메뉴 묶음 */
.menu-item{
    width:100%;
}

.menu-item a {
    color: inherit;          /* 부모 색상 사용 */
    text-decoration: none;   /* 밑줄 제거 */
}

.menu-item a:hover {
    color: inherit;          /* 부모 색상 사용 */
    text-decoration: none;   /* 밑줄 제거 */
}

/* 상위 메뉴 */
.menu-title{
    padding:15px 20px;
    font-size:15px;
    font-weight:600;
    background:#393E46;
    cursor:pointer;
    transition:background 0.2s;
}

.menu-title:hover{
    background:#4b5457;
}

/* 서브메뉴 (기본 숨김) */
.submenu{
    list-style:none;
    margin:0;
    padding:0;
    max-height:0; 

    overflow:hidden; 

    background:#2f3638; 
    
    transition:max-height 0.35s ease;
}

/* 열렸을 때 */ 
.menu-item.active .submenu{ 
    max-height:500px; 
} 

/* submenu item */ 
.submenu li{ 
    padding:13px 35px; 
    border-bottom:1px solid #3b3b3b; 
    cursor:pointer; 
    transition:background 0.2s; 
} 
.submenu li:hover{ 
    background:#4b5457; 
}

/* =========================
    CONTENT
========================= */

.content{
    flex:1;
    padding:30px;
    overflow-y:auto;
}

.content-box{
    width:100%;
    min-height:700px;

    background:white;
    border-radius:10px;

    padding:30px;

    box-shadow:0 2px 10px rgba(0,0,0,0.08);
}

</style>
</head>
<body>
    <%-- 
		* menubar.jsp 에 공통 코드 작업을 해볼 것!!
		- 1회성 alert 기능
		- script 태그 내에서는 JSP Action Tag 들이 사용 불가함!! (자바스크립트 영역이기 때문)
	--%>
	<c:if test="${ not empty sessionScope.alertMsg }">
		<script>
			
			let alertMsg = "${ sessionScope.alertMsg }";
			
			// alert(alertMsg);
			alertify.alert(alertMsg, function(){ alertify.success('Ok'); });
			
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>
<div class="wrap">

    <!-- HEADER -->
    <div class="header">

        <div class="header-left">
            <a href="/burgerstack/admin/dashboard" class="brand-link">
                <img src="${pageContext.request.contextPath}/resources/images/BS_logo2.png" alt="logo" class="logo">
                <span class="system-title">BurgerStack ERP</span>
            </a>
        </div>

        <div class="header-right">
            <span>관리자님 환영합니다.</span>
            <button class="logout-btn">로그아웃</button>
        </div>

    </div>

    <div class="body-area">

        <!-- MenuBar -->
        <div class="menubar">

            <div class="profile-box">
                <span class="profile-name">관리자</span>
                <span class="profile-role"><a class="link" href="/burgerstack/admin/mypage">마이페이지</a></span>
                <div class="profile-role">총괄 관리자</div>
            </div>

            <div class="menu">

                <!-- 점주 관리 -->
                <div class="menu-item">

                    <div class="menu-title">
                        점주 관리
                    </div>

                    <ul class="submenu">
                        <a href="/burgerstack/admin/users"><li>점주 조회</li></a>
                        <a href="/burgerstack/admin/users/new"><li>점주 등록</li></a>
                    </ul>

                </div>

                <!-- 점포 관리 -->
                <div class="menu-item">

                    <div class="menu-title">
                        점포 관리
                    </div>

                    <ul class="submenu">
                        <a href="/burgerstack/admin/stores"><li>점포 조회</li></a>
                        <a href="/burgerstack/admin/stores/new"><li>점포 등록</li></a>
                    </ul>

                </div>

                <!-- 점포 재고 모니터링 -->
                <div class="menu-item">

                    <div class="menu-title">
                        점포 재고 모니터링
                    </div>

                    <ul class="submenu">
                        <a href="/burgerstack/admin/inventories/{inventoryId}/edit"><li>점포 재고 조정</li></a>
                        <a href="/burgerstack/admin/inventories"><li>재고 목록 조회</li></a>
                        <a href="/burgerstack/admin/inventory-transactions?storeId={storeId}"><li>점포별 재고 변동 이력 조회</li></a>
                        <a href="/burgerstack/admin/receipts"><li>입고 이력 조회</li></a>
                        <a href="/burgerstack/admin/closings"><li>마감 이력 조회</li></a>
                    </ul>

                </div>

                <!-- 발주 관리 -->
                <div class="menu-item">

                    <div class="menu-title">
                        발주 관리
                    </div>

                    <ul class="submenu">
                        <a href="/burgerstack/admin/purchases?status=REQUESTED"><li>발주 승인 대기 조회</li></a>
                        <a href="/burgerstack/admin/purchases"><li>발주 조회</li></a>
                    </ul>

                </div>

                <!-- 자재 관리 -->
                <div class="menu-item">

                    <div class="menu-title">
                        자재 관리
                    </div>

                    <ul class="submenu">
                        <a href="/burgerstack/admin/materials"><li>자재 조회</li></a>
                        <a href="/burgerstack/admin/materials/new"><li>자재 등록</li></a>
                    </ul>

                </div>



                <!-- 공지사항 -->
                <div class="menu-item">

                    <div class="menu-title">
                        공지사항
                    </div>

                    <ul class="submenu">
                        <a href="/burgerstack/admin/notices"><li>공지사항 목록</li></a>
                        <a href="/burgerstack/admin/notices/new"><li>공지사항 등록</li></a>
                    </ul>

                </div>

                <!-- 문의사항 -->
                <div class="menu-item">

                    <div class="menu-title">
                        문의사항
                    </div>

                    <ul class="submenu">
                        <a href="/burgerstack/admin/inquiries"><li>문의사항 목록</li></a>
                    </ul>

                </div>

            </div>

        </div>

        <!-- CONTENT -->
        <div class="content">

            <div class="content-box">

                <!-- 각 페이지 내용 출력 -->
                <jsp:doBody />

            </div>

        </div>


    </div>

</div>

<script> 
    const menuTitles = document.querySelectorAll('.menu-title'); 

    menuTitles.forEach(title => { 
        title.addEventListener('click', () => { 
            const menuItem = title.parentElement; 

            // 현재 메뉴 toggle 
            menuItem.classList.toggle('active'); 
        }); 
    }); 
</script>

</body>
</html>