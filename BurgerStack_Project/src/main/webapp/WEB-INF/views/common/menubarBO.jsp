<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="jakarta.tags.core" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BurgerStack</title>
<link rel="shortcut icon" type="image/x-icon" href="/resources/images/BS_logo2.png" />
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

        cursor:pointer;
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
        min-height:500px;

        background:white;
        border-radius:10px;

        padding:30px;

        box-shadow:0 2px 10px rgba(0,0,0,0.08);
    }

</style>

<!-- alertify 라이브러리 연동 구문 -->
<!-- JavaScript -->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
<!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>

<!-- JSP 에서 부트스트랩 연동도 가능함!! -->
<!-- 부트스트랩 CDN 방식으로 연동하는 구문들 -->
<!-- 예쁘게 정의된 스타일들이 들어 있는 CSS 파일 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- 간단한 동작들을 정의해둔 JS 파일 -->
<!-- 온라인 방식 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<!-- 점포 공통 레이아웃 -->

<div class="wrap">

    <!-- HEADER -->
    <div class="header">

        <div class="header-left">
            <div class="logo">BS</div>
            <div class="system-title">BurgerStack ERP</div>
        </div>

        <div class="header-right">
            <span>관리자님 환영합니다.</span>
            <button class="logout-btn">로그아웃</button>
        </div>

    </div>

    <!-- BODY -->
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
                    <li>점포 조회</li>
                    <li>점포 등록</li>
                    <li>점포 수정</li>
                </ul>

                <div class="menu-title">
                    재고 관리
                </div>

                <ul class="submenu">
                    <li>재고 조회</li>
                    <li>입고 관리</li>
                    <li>출고 관리</li>
                </ul>

                <div class="menu-title">
                    발주 관리
                </div>

                <ul class="submenu">
                    <li>발주 등록</li>
                    <li>발주 조회</li>
                </ul>

                <div class="menu-title">
                    게시판
                </div>

                <ul class="submenu">
                    <li>공지사항</li>
                    <li>문의사항</li>
                </ul>

            </div>

        </div>

        <!-- CONTENT -->
        <div class="content">

            <div class="content-box">

                <h3>메인 컨텐츠 영역</h3>

                <hr>

                구현할 화면 내용 작성

            </div>

        </div>

    </div>

</div>

</body>
</html>