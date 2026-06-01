<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .all-list {
        /* background-color : lightcoral; */
        margin : auto;
        padding : 15px;
        width : 80%;
    }
    .all-list>h1 {
        margin : 20px;
    }
    .img-wrap {
        /* border : 1px solid lightgray; */
        display : inline-block;
        margin : 20px;
        margin-top : 0px;
    }
    .category-title {
        margin : 20px;
    }
    .img-wrap>img{
        width : 200px;
        height : 200px;
    }
    .img-wrap>b {
        margin : 10px;
    }

    /* 드로어 */
    .detail-drawer {
    position: fixed;
    top: 0;
    right: -400px; /* 드로어 너비만큼 오른쪽 화면 바깥으로 밀어내서 숨김 */
    width: 400px;
    height: 100vh;
    background-color: #ffffff;
    box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1); /* 왼쪽에 은은한 그림자 */
    transition: right 0.3s ease-in-out; /* 0.3초 동안 스르륵 움직이는 효과 */
    z-index: 1000; /* 화면 최상단에 뜨도록 설정 */
    padding: 30px;
    box-sizing: border-box;
    }

    /* ⚡ 자바스크립트로 이 클래스를 붙이면 오른쪽에서 튀어나옴! */
    .detail-drawer.open {
    right: 0;
    }

    /* 드로어 내부 헤더 */
    .drawer-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #eee;
    padding-bottom: 15px;
    margin-bottom: 20px;
    }

    .close-btn {
    background: none;
    border: none;
    font-size: 28px;
    cursor: pointer;
    color: #999;
    }

    .close-btn:hover {
    color: #333;
    }
</style>
</head>
<body> 
    <!-- 자재 등록 페이지 -->
    <jsp:include page="../common/menubarHO.jsp" />
    
</body>
</html>