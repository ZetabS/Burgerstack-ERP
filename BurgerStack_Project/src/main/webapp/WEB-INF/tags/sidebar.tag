<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="false" %>
<%@ tag body-content="scriptless" %>
<%@ attribute name="sidebarTitle" fragment="true" required="true" %>

<%--
사용법
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:sidebar>
    <jsp:attribute name="sidebarTitle">
        사이드바 제목(필수)
    </jsp:attribute>
    <jsp:body>
        사이드바 내용
    </jsp:body>
</t:sidebar>
--%>
    <!-- 사이드바 열 버튼 -->
    <div class="open-box" onclick="openSidebar()">
        <img src="https://img.icons8.com/ios/50/left-squared--v1.png" alt="left-squared--v1"/>
    </div>

    <!--  오른쪽에서 튀어나올 상세 페이지 드로어 -->
    <div id="detailDrawer" class="detail-drawer">
        <br><br>
        <div class="drawer-header">
            <h2>
                <jsp:invoke fragment="sidebarTitle" />
            </h2>

            <!-- 닫기 버튼 -->
            <div class="close-btn" onclick="closeSidebar()">&times;</div>
        </div>
        <div class="drawer-content">
            <br>
            <!-- 사이드 바 내용 출력 -->
            <jsp:doBody />
        </div>
    </div>

    <script>
        function openSidebar() {
            // 드로어 정면에 open 클래스 추가해서 화면에 등장시키기
            document.getElementById('detailDrawer').classList.add('open');
        }

        // 드로어 닫기 함수
        function closeSidebar() {
        // open 클래스를 제거해서 다시 오른쪽으로 숨기기
        document.getElementById('detailDrawer').classList.remove('open');
        }
    </script>

