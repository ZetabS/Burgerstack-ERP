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

        body{
        background:#f5f6fa;
        font-family:'Malgun Gothic';
    }

    .outer{
        width:1000px;
        margin:auto;
        margin-top:40px;
    }

    .title-area{
        margin-bottom:30px;
    }

    .title-area h2{
        font-weight:700;
    }

    /* 검색창 */

    .search-area{
        display:flex;
        justify-content:flex-end;
        margin-bottom:10px;
    }

    .search-form{
        display:flex;
        align-items:center;
    }

    .search-form input{
        width:220px;
        height:38px;
        border:1px solid #cfd3d7;
        border-right:none;
        padding-left:10px;
        outline:none;
    }

    .search-btn{
        width:45px;
        height:38px;
        border:none;
        background:#6c7a92;
        color:white;
        font-size:18px;
        cursor:pointer;
    }

    /* 테이블 */

    .board-table{
        width:100%;
        background:white;
        border-collapse:collapse;
    }

    .board-table thead{
        background:#20bf55;
        color:white;
    }

    .board-table th{
        padding:12px;
        text-align:center;
        font-size:14px;
    }

    .board-table td{
        padding:14px 10px;
        text-align:center;
        border-bottom:1px solid #f1f1f1;
        font-size:14px;
    }

    .board-table tbody tr:hover{
        background:#f8f9fa;
        cursor:pointer;
    }

    .title-col{
        text-align:left !important;
        padding-left:20px !important;
    }

    /* 페이지 영역 */

    .paging-area{
        margin-top:30px;
        text-align:center;
    }

    .paging-area a{
        margin:0 5px;
        text-decoration:none;
        color:#4c6ef5;
        font-size:18px;
    }

    .paging-area a:hover{
        font-weight:bold;
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

<!-- 본사 공통 레이아웃 -->

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

                <div class="outer">

    <!-- 제목 -->
    <div class="title-area">
        <h2>공지사항</h2>
    </div>

    <!-- 검색 -->
    <div class="search-area">

        <form class="search-form" action="" method="get">

            <input type="text"
                   name="keyword"
                   placeholder="검색어 입력">

            <button type="submit" class="search-btn">
                검색
            </button>

        </form>

    </div>

    <!-- 테이블 -->
    <table class="board-table">

        <thead>

            <tr>
                <th width="10%">글번호</th>
                <th width="55%">제목</th>
                <th width="15%">조회수</th>
                <th width="20%">등록일자</th>
            </tr>

        </thead>

        <tbody>

            <tr>
                <td>10</td>
                <td class="title-col">
                    공지사항입니다 대충 무슨무슨 이벤트
                    (01/01 ~ 01/30 까지)
                </td>
                <td>32</td>
                <td>2026-05-24</td>
            </tr>

            <tr>
                <td>9</td>
                <td class="title-col">
                    공지사항입니다 대충 제목
                </td>
                <td>123</td>
                <td>2026-05-24</td>
            </tr>

            <tr>
                <td>8</td>
                <td class="title-col">
                    공지사항입니다 대충 제목
                </td>
                <td>789</td>
                <td>2026-05-24</td>
            </tr>

            <tr>
                <td>7</td>
                <td class="title-col">
                    공지사항입니다 대충 제목
                </td>
                <td>561</td>
                <td>2026-05-24</td>
            </tr>

            <tr>
                <td>6</td>
                <td class="title-col">
                    공지사항입니다 대충 제목
                </td>
                <td>1230</td>
                <td>2026-05-24</td>
            </tr>

        </tbody>

    </table>

    <!-- 페이지 -->
    <div class="paging-area">

        <a href="#">&lt;&lt;</a>
        <a href="#">&lt;</a>

        <a href="#">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>

        <a href="#">&gt;</a>
        <a href="#">&gt;&gt;</a>

    </div>

</div>


            </div>

        </div>

    </div>

</div>

</body>
</html>