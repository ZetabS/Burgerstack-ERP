<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자재 목록 상세 조회</title>
    <style>
        .all-list { margin: auto; padding: 15px; width: 80%; }
        .category-section { margin-bottom: 40px; }
        .category-title { margin: 20px; border-bottom: 2px solid #ddd; padding-bottom: 10px; }
        .product-grid { display: flex; flex-wrap: wrap; gap: 20px; padding: 0 20px; }
        
        
        
    </style>
</head>
<body> 

    <t:menubarBO>
        <!-- 우측 상세 정보 사이드바(드로어) -->
        <t:sidebar>
                <jsp:attribute name="sidebarTitle">
                    <span id="drawerSidebarTitle">자재 상세 정보</span>
                </jsp:attribute>
                <jsp:body>
                    <br>
                    <img id="drawerImage" src="" alt="자재 이미지" style="display: none; width: 60%; margin: 0 auto; border-radius: 8px; border: 1px solid #ddd; padding: 5px;">
                    
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
                            <strong>상태 :</strong> <span id="drawerStatus" class="badge">상태 정보</span> <br>
                            <strong>원가 :</strong> <span id="drawerCostPrice" style="color: #65a30d; font-weight: bold;">0</span>원<br>
                            <strong>판매가 :</strong> <span id="drawerSellingPrice" style="color: #2563eb; font-weight: bold;">0</span>원
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

                    <%-- 클릭 시 materialId만 AJAX 함수로 전달 --%>
                    <div class="img-wrap" onclick="getMaterialDetail('${m.materialId}', '${m.materialName}')">
                        <b>${m.materialName}</b>
                        <br>
                        <c:set var="imgSrc" value="${not empty m.imageFileId ? m.imageFileId : 'BS_logo1.svg'}" />
                        <img src="${pageContext.request.contextPath}/resources/images/${imgSrc}" alt="${m.materialName}">
                    </div>
                </c:forEach>
                </div></div>
        </div>
    </t:menubarBO>

    <!-- 깜빡임 방지 AJAX 스크립트 -->
    <script>
        function getMaterialDetail(materialId, name) {
            
            if (name) {
                document.getElementById('drawerSidebarTitle').innerText = name;
            }
            
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/materials/detail", 
                type: "GET",
                data: { materialId: materialId }, 
                dataType: "json", 
                success: function(data) {
                    // 1. 이미지 처리
                    var imgEl = document.getElementById('drawerImage');
                    var srcName = data.imageFileId ? data.imageFileId : 'BS_logo1.svg';
                    imgEl.src = "${pageContext.request.contextPath}/resources/images/" + srcName;
                    imgEl.style.display = 'block';
                    
                    // 2. 원가 및 판매가 매핑 (천단위 콤마 추가)
                    document.getElementById('drawerCostPrice').innerText = data.costPrice ? Number(data.costPrice).toLocaleString() : '0';
                    document.getElementById('drawerSellingPrice').innerText = data.sellingPrice ? Number(data.sellingPrice).toLocaleString() : '0';
                    
                    // 3. 상세 설명 매핑
                    document.getElementById('drawerDetails').innerText = data.details ? data.details : '등록된 자재 설명이 없습니다.';
                    
                    // 4. 상태(Status) 뱃지 클래스 및 텍스트 변경
                    var statusEl = document.getElementById('drawerStatus');
                    if (data.status === 'Y' || data.status === 'ACTIVE' || data.status === '판매중') {
                        statusEl.innerText = '판매중';
                        statusEl.className = 'badge badge-success';
                    } else {
                        statusEl.innerText = data.status ? data.status : '중단';
                        statusEl.className = 'badge badge-danger';
                    }
                    
                    // 5. DB에서 조회해온 실시간 재고(수량) 바인딩
                    document.getElementById('drawerStock').innerText = data.currentQuantity ? data.currentQuantity + ' ea' : '0 ea'; 
                    
                    // 6. 모든 세팅이 끝나면 우측 드로어 개방
                    if (typeof openSidebar === 'function') {
                        openSidebar();
                    } else {
                        var drawer = document.getElementById('detailDrawer');
                        if(drawer) drawer.classList.add('open');
                    }
                },
                error: function(xhr, status, error) {
                    alert("자재 정보를 실시간으로 가져오는데 실패했습니다.");
                    console.error(error);
                }
            });
        }
    </script>
</body>
</html>