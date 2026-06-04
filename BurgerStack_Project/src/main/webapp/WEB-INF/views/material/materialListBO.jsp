<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자재 목록 전체 조회</title>
    <style>
        .all-list { margin: auto; padding: 15px; width: 80%; }
        .category-section { margin-bottom: 40px; }
        .category-title { margin: 20px; border-bottom: 2px solid #ddd; padding-bottom: 10px; }
        .product-grid { display: flex; flex-wrap: wrap; gap: 20px; padding: 0 20px; }
        
        /* 💡 만약 레이아웃 템플릿에에 따라 사이드바가 안 보일 때를 대비한 안전장치 CSS */
        aside.open, .sidebar.open, #detailDrawer.open {
            display: block !important;
            transform: translateX(0) !important;
            right: 0 !important;
        }
    </style>
</head>
<body> 

    <!-- 💡 현재 UI가 관리자 메뉴바인 <t:menubarHO>를 바라보고 있습니다. 
         만약 점주 전용 메뉴바 태그(예: <t:menubarJO> 등)가 따로 있다면 이 태그명을 꼭 변경해 주세요! -->
    <t:menubarBO>
        <!-- 우측 상세 정보 사이드바(드로어) -->
        <t:sidebar>
            <jsp:attribute name="sidebarTitle">
                <span id="drawerSidebarTitle">자재 상세 정보</span>
            </jsp:attribute>
            <jsp:body>
                <br>
                <img id="drawerImage"
                     src=""
                     alt="자재 이미지"
                     onerror="this.src='${pageContext.request.contextPath}/resources/images/BS_logo1.svg'"
                     style="display: none; width: 60%; margin: 0 auto; border-radius: 8px; border: 1px solid #ddd; padding: 5px;">
                
                <br>
                
                <div class="drawer-info-wrap" style="width: 80%; margin: 0 auto; color: #4a5568; line-height: 1.8; font-size: 15px;">
                
                    <hr style="margin: 15px 0; border-top: 1px solid #e2e8f0;">
                    
                    <div id="drawerDetails" style="background-color: #f8fafc; padding: 10px; border-radius: 6px; font-style: italic; color: #64748b; min-height: 40px;">
                        <!-- AJAX 데이터 주입 구역 -->
                    </div>
                    <hr style="margin: 15px 0; border-top: 1px solid #e2e8f0;">
                    
                    <!-- 가격, 재고 및 상태 정보 (status) -->
                    <div>
                        <p>
                            <strong>재고 :</strong> <span id="drawerStock" style="color: #ff7a00; font-weight: bold;">10 ea</span><br>
                            <strong>원가 :</strong> <span id="drawerCostPrice" style="color: #65a30d; font-weight: bold;">0</span>원<br>
                            <strong>판매가 :</strong> <span id="drawerSellingPrice" style="color: #2563eb; font-weight: bold;">0</span>원<br>
                            <strong>상태 :</strong> <span id="drawerStatus" class="badge">상태 정보</span>
                        </p>
                    </div>
                </div>
            </jsp:body>
        </t:sidebar>

        <!-- 본문 리스트 영역 -->
        <div class="all-list">
            <h1>자재 목록 상세 조회</h1>

            <div class="category-section">
                <c:forEach var="m" items="${materials}" varStatus="status">
                    <c:if test="${status.first || m.materialType != materials[status.index - 1].materialType}">
                        <c:if test="${!status.first}"></div></div><div class="category-section"></c:if>
                        <h2 class="category-title">
                            <c:choose>
                                <c:when test="${m.materialType eq 'RF'}">냉장식품</c:when>
                                <c:when test="${m.materialType eq 'FF'}">냉동식품</c:when>
                                <c:when test="${m.materialType eq 'AF'}">상온식품</c:when>
                                <c:when test="${m.materialType eq 'PK'}">포장재</c:when>
                                <c:when test="${m.materialType eq 'KW'}">주방용품</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </h2>
                        <div class="product-grid">
                    </c:if>

                    <div class="img-wrap" onclick="MaterialDrawer.getDetail('${m.materialId}', '${m.materialName}')" style="cursor: pointer;">
                        <b>${m.materialName}</b><br>
                        <c:choose>
                            <c:when test="${empty m.imageFileId}">
                                <img src="${pageContext.request.contextPath}/resources/images/BS_logo1.svg" alt="${m.materialName}">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/files/${m.imageFileId}" alt="${m.materialName}">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
                </div></div>
        </div>
    </t:menubarBO>

    <script>
        /**
         * 자재 드로어 및 이벤트를 관리하는 모듈 객체
         */
        const MaterialDrawer = {
            contextPath: "",

            init: function(contextPath) {
                this.contextPath = contextPath;
            },

            getDetail: function(materialId, name) {
                if (name) {
                    const titleEl = document.getElementById('drawerSidebarTitle');
                    if (titleEl) titleEl.innerText = name;
                }

                // 💡 [수정] AJAX 요청 경로를 점주용 경로(owner/materials)로 전면 수정했습니다.
                $.ajax({
                    url: this.contextPath + "/owner/materials/detail",
                    type: "GET",
                    data: { materialId: materialId },
                    dataType: "json",
                    success: (data) => {
                        this.bindData(data);
                        this.open();
                    },
                    error: (xhr, status, error) => {
                        alert("자재 정보를 실시간으로 가져오는데 실패했습니다.");
                        console.error(error);
                    }
                });
            },

            bindData: function(data) {
                const imgEl = document.getElementById('drawerImage');
                if (imgEl) {
                    const fallback = this.contextPath + "/resources/images/" + 'BS_logo1.svg';
                    imgEl.src = data.imageFileId ? this.contextPath + '/files/' + data.imageFileId : fallback;
                    imgEl.style.display = 'block';
                }

                if(document.getElementById('drawerCostPrice')) {
                    document.getElementById('drawerCostPrice').innerText = data.costPrice ? Number(data.costPrice).toLocaleString() : '0';
                }
                if(document.getElementById('drawerSellingPrice')) {
                    document.getElementById('drawerSellingPrice').innerText = data.sellingPrice ? Number(data.sellingPrice).toLocaleString() : '0';
                }

                if(document.getElementById('drawerDetails')) {
                    document.getElementById('drawerDetails').innerText = data.details ? data.details : '등록된 자재 설명이 없습니다.';
                }

                const statusEl = document.getElementById('drawerStatus');
                if (statusEl) {
                    if (data.status === 'Y' || data.status === 'ACTIVE' || data.status === '판매중') {
                        statusEl.innerText = '판매중';
                        statusEl.className = 'badge badge-success';
                    } else {
                        statusEl.innerText = data.status ? data.status : '중단';
                        statusEl.className = 'badge badge-danger';
                    }
                }

                if(document.getElementById('drawerStock')) {
                    document.getElementById('drawerStock').innerText = data.currentQuantity ? data.currentQuantity + ' ea' : '0 ea';
                }
            },

            open: function() {
                // 💡 점주 메뉴바 환경에 맞춰 스크립트가 유연하게 요소를 열 수 있도록 보완한 open 로직
                if (typeof openSidebar === 'function') {
                    openSidebar();
                } else {
                    const drawer = document.getElementById('detailDrawer') 
                                 || document.querySelector('aside') 
                                 || document.querySelector('.sidebar');
                    if(drawer) {
                        drawer.classList.add('open');
                        drawer.style.display = 'block';
                    }
                }
            }
        };
    </script>
    
    <script>
        MaterialDrawer.init("${pageContext.request.contextPath}");
    </script>
    
</body>
</html>