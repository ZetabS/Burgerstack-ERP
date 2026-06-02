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
      href="/resources/images/BS_logo2.png" />

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

.logo{
    font-size:28px;
    font-weight:700;
    color:#ff6b00;
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
    SIDEBAR
========================= */

.sidebar{
    width:250px;
    background:#2d3436;
    color:white;

    overflow-y:auto;
}

.sidebar a {
    color: white;
    text-decoration: none;
    display: block;
}

.sidebar a:visited {
    color: white;
}

.sidebar a:hover {
    color: white;
    text-decoration: none;
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

.menu-title{
    padding:15px 20px;
    font-size:15px;
    font-weight:600;
    background:#393E46;
}

.submenu{
    list-style:none;
    margin:0;
}

.submenu li{
    padding:13px 35px;
    font-size:14px;
    border-bottom:1px solid #3b3b3b;
    cursor:pointer;
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

<div class="wrap">

    <!-- HEADER -->
    <div class="header">

        <div class="header-left">

            <div class="logo">
                <img src="${pageContext.request.contextPath}/resources/images/BS_logo2.png"
                     style="width:32px;">
            </div>

            <div class="system-title">
                BurgerStack ERP
            </div>

        </div>

        <div class="header-right">
            <span>관리자님 환영합니다.</span>
            <button class="logout-btn">로그아웃</button>
        </div>

    </div>

    <div class="body-area">

        <!-- SIDEBAR -->
        <div class="sidebar">

            <div class="profile-box">
                <div class="profile-name">관리자</div>
                <div class="profile-role">총괄 관리자</div>
            </div>

            <div class="menu">

                <div class="menu-title">
                    점포 관리
                </div>

                <ul class="submenu">
				    <li>
				        <a href="/burgerstack/store/list">
						    점포 조회
						</a>
				    </li>
				
				    <li>
				        <a href="${pageContext.request.contextPath}/store/enroll">
				            점포 등록
				        </a>
				    </li>
				</ul>

                <div class="menu-title">
                    점포 재고 모니터링
                </div>

                <ul class="submenu">
                    <li>이상 재고 변동 조회</li>
                    <li>점포별 재고 변동 이력 조회</li>
                    <li>점포별 재고 현황 조회</li>
                    <li>점포 재고 조정</li>
                </ul>

                <div class="menu-title">
                    재고 관리
                </div>

                <ul class="submenu">
                    <li>재고 조회</li>
                    <li>재고 등록</li>
                </ul>

                <div class="menu-title">
                    발주 관리
                </div>

                <ul class="submenu">
                    <li>발주 조회</li>
                </ul>

                <div class="menu-title">
                    공지사항
                </div>

                <ul class="submenu">
                    <li>공지사항 목록</li>
                    <li>공지사항 등록</li>
                </ul>

                <div class="menu-title">
                    문의사항
                </div>

                <ul class="submenu">
                    <li>문의사항 목록</li>
                    <li>문의사항 등록</li>
                </ul>

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

</body>
</html>