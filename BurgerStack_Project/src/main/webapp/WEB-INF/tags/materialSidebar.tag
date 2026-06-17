<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="false" %>
<%@ tag body-content="scriptless" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title><c:out value="${empty title ? 'BurgerStack ERP' : title}" /></title>

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
        top: 70px;
        right: -400px; /* 드로어 너비만큼 오른쪽 화면 바깥으로 밀어내서 숨김 */
        width: 400px;
        height: calc(100vh - 70px); /* 전체 화면 높이(100vh)에서 헤더 높이만큼 제외 */
        background-color: #ffffff;
        box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1); /* 왼쪽에 은은한 그림자 */
        transition: right 0.3s ease-in-out; /* 0.3초 동안 스르륵 움직이는 효과 */
        z-index: 1000; /* 화면 최상단에 뜨도록 설정 */
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
        width:50%;
        border-radius:8px;
        padding : 10px;
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
            <!-- 사이드 바 내용 출력 -->
            <jsp:doBody />
        </div>
    </div>

    <script>
        function openDrawer(matName, imgSrc, matCode, matType, price, discription, curQuantity, status) {
            // 드로어 내부
            document.getElementById('drawerTitle').innerText = matName;
            document.getElementById('drawerImg').src = imgSrc;

            let desc1 = "<div id='detailContent'>"
                            + "<p>"
                            +      "자재 코드 : " + matCode + "<br>"
                            +      "자재명 : " + matName + "<br>"
                            +      "자재 유형 : " + matType + "<br>"
                            +      "단가 : " + price + "원<br>"
                            +      "[상세 설명]<br>" + discription
                            + "</p>"
                            + "<br>"
                    + "</div>"
                    + "<hr><br>";
            let desc2 = "<div id='detailContent'>"
                            + "<p>"
                            +      "재고 : " + curQuantity + " ea<br>"
                            +      "상태 : " + status
                            + "</p>"
                    + "</div>";
            document.getElementById('drawerDesc1').innerHTML = desc1;
            document.getElementById('drawerDesc2').innerHTML = desc2;

            // 드로어 정면에 open 클래스 추가해서 화면에 등장시키기
            document.getElementById('detailDrawer').classList.add('open');
        }

        // 드로어 닫기 함수
        function closeDrawer() {
            // open 클래스를 제거해서 다시 오른쪽으로 숨기기
            document.getElementById('detailDrawer').classList.remove('open');
        }
    </script>
</body>
</html>
