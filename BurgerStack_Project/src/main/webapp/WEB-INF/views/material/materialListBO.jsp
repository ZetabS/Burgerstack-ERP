<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
        cursor : pointer;
    }
    .category-title {
        margin : 20px;
    }
    .img-wrap>img{
        width : 200px;
        height : 200px;
        border : 1px solid lightgray;
    }
    .img-wrap>b {
        margin : 10px;
    }

    /* 드로어 */
    .detail-drawer {
    position: fixed;
    top: 0;
    right: -400px;
    width: 400px;
    height: 100vh;
    background-color: #ffffff;
    box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);
    transition: right 0.3s ease-in-out;
    z-index: 1000;
    box-sizing: border-box;
    }

    /* 오른쪽에서 튀어나오게 */
    .detail-drawer.open {
    right: 0;
    }

    /* 드로어 내부*/
    .drawer-header {
        display : flex;
        justify-content: space-between;
        padding-left: 50px;
        align-items: center;
        background-color : #FF7A00;
        color : white;
    }
    .drawer-header>h2 {
        margin-block : 10px;
    }
    .drawer-content {
        width : 100%;
    }
    
    #detailContent>p, #drawerName {
        margin : 0 auto;
        width : 70%;
    }
    .drawer-content>img {
        border : 1px solid lightgray;
        width: 200px;
        height : 200px;
        border-radius:8px;
        display : block;
        margin : 0 auto;
    }
    
    .close-btn {
        background: none;
        border: none;
        font-size: 28px;
        cursor: pointer;
        color: #64748B;
    }

    .close-btn:hover {
    color: #1F2937;
    }
</style>
</head>
<body> 
    <!-- 자재 목록 보기 + 상세 정보 페이지 -->
    <jsp:include page="../common/menubarBO.jsp" />
    <div class="all-list">

        <h1>자재 목록 상세 조회</h1>

        <div class="category-section">
            <h2 class="category-title">냉장식품</h2>
            <!-- 분류 -->
            <div class="product-grid">
                <!-- 개별 상품 카드 -->
                <div class="img-wrap" onclick="openDrawer('양상추', 'C:/00_Semi_Workspace/BurgerStack_Project/src/main/webapp/resources/images/burgerstack_logo_s.png')">
                    <b>양상추</b>
                    <br>
                    <img src="C:\00_Semi_Workspace\BurgerStack_Project\src\main\webapp\resources\images\BS_logo1.svg">
                </div>
                <div class="img-wrap">
                    <b>토마토</b>
                    <br>
                    <img src="" >
                </div>
                <div class="img-wrap">
                    <b>베이컨</b>
                    <br>
                    <img src="" >
                </div>
            </div>
        </div>

        <div class="category-section">
            <!-- 분류 -->
            <h2 class="category-title">냉동식품</h2>
            <div class="product-grid">
                <!-- 개별 상품 카드 -->
                <div class="img-wrap">
                    <b>돼지고기패티</b>
                    <br>
                    <img src="">
                </div>
                <div class="img-wrap">
                    <b>소고기패티</b>
                    <br>
                    <img src="" >
                </div>
                <div class="img-wrap">
                    <b>텐더그릴치킨패티</b>
                    <br>
                    <img src="" >
                </div>
                
            </div>
        </div>

        <div class="category-section">
            <!-- 분류 -->
            <h2 class="category-title">상온식품</h2>
            <div class="product-grid">
                <!-- 개별 상품 카드 -->
                <div class="img-wrap">
                    <b>블랙올리브</b>
                    <br>
                    <img src="">
                </div>
                <div class="img-wrap">
                    <b>케첩</b>
                    <br>
                    <img src="">
                </div>
                <div class="img-wrap">
                    <b>데리야끼소스</b>
                    <br>
                    <img src="">
                </div>
            </div>
        </div>

        <div class="category-section">
            <!-- 분류 -->
            <h2 class="category-title">비식품자재</h2>
            <div class="product-grid">
                <!-- 개별 상품 카드 -->
                <div class="img-wrap">
                    <b>버거 박스(사각)</b>
                    <br>
                    <img src="">
                </div>
                <div class="img-wrap">
                    <b>소스통</b>
                    <br>
                    <img src="">
                </div>
                <div class="img-wrap">
                    <b>스테인리스 트레이(소형)</b>
                    <br>
                    <img src="">
                </div>
                </div>
        </div>

        <!--  오른쪽에서 튀어나올 상세 페이지 드로어 /하드코딩 -->
        <div id="detailDrawer" class="detail-drawer">
            <br><br>
            <div class="drawer-header">
                <h2 id="drawerTitle">자재 이름</h2>
                <!-- 닫기 버튼 -->
                <button class="close-btn" onclick="closeDrawer()">&times;</button>
            </div>
            <div class="drawer-content">
                <br>
                <img id="drawerImg" src="" align="center">
                <br>
                <h3 id="drawerName">자재 상세 정보</h3>
                <p id="drawerDesc1"></p>
                <h3 id="drawerName">자재 현황</h3>
                <p id="drawerDesc2"></p>
            </div>
        </div>
    </div>

    <script>
        function openDrawer(name, imgSrc) {
        // 드로어 내부
        document.getElementById('drawerTitle').innerText = name;
        document.getElementById('drawerImg').src = imgSrc;

        let desc1 = "<div id='detailContent'>"
                  + "<p>"
                  +      "등록일자 : 2026-06-02" + "<br>"
                  +      "재질 : pp / 종이" + "<br>"
                  +      "가로 : 15 cm" + "<br>"
                  +      "세로 : 15 cm" + "<br>"
                  +      "높이 :  10 cm" + "<br>"
                  +       "판매가 :  100 원"
                  + "</p>"
                  + "<br>"
                  + "</div>"
                  + "<hr>" + "<br>";
        let desc2 = "<div id='detailContent'>"
                  + "<p>"
                  +      "재고 : 10 ea" + "<br>"
                  +      "상태 : 판매중"
                  + "</p>"
                  + "</div>";
        document.getElementById('drawerDesc1').innerHTML = desc1;
        document.getElementById('drawerDesc2').innerHTML = desc2;

        
        document.getElementById('detailDrawer').classList.add('open');
        }

        // 드로어 닫기 함수
        function closeDrawer() {
        document.getElementById('detailDrawer').classList.remove('open');
        }
    </script>
</body>
</html>