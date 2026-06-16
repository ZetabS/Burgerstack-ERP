<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
    <style>
        /* 1. 기본 레이아웃 */
        .all-list { margin: auto; padding: 15px; width: 80%; }
        .category-section { margin-bottom: 40px; }
        .category-title { margin: 20px; border-bottom: 2px solid #ddd; padding-bottom: 10px; }

        /* 2. 그리드 배치 */
        .product-grid { 
            display: flex; 
            flex-wrap: wrap; 
            gap: 15px; 
            padding: 0 20px; 
        }

        /* 3. 카드 전체 디자인 */
        .product-grid .img-wrap {
            width: 150px;
            height: 190px;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 10px;
            background-color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* 위아래로 요소들을 쫙 벌림 */
            align-items: center;
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
            cursor: pointer;
            transition: transform 0.1s, box-shadow 0.1s;
            overflow: hidden;
        }

        .product-grid .img-wrap:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        /* 4. 제목 (2줄 고정) */
        .product-grid .img-wrap b {
            font-size: 13px;
            line-height: 1.3;
            color: #1e293b;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            height: 20px;
            word-break: break-all;
            margin: 0;
        }

        /* 5. 이미지 */
        .product-grid .img-wrap img {
            width: 100%;
            height: 110px;
            object-fit: cover;
            border-radius: 8px;
            margin: 8px 0;
        }

        /* 6. 카드 하단 (가격 + 상태) */
        .card-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin-top: auto; /* 아래쪽으로 밀착 */
        }

        .drawer-container {
            display: flex;
            flex-direction: column;
            height: 75vh;
            
            width: 80%;
            margin: 0 auto;
            padding: 12px;
        }

        .drawer-scroll-content {
            width: 100%;             /* 부모의 80% 너비를 꽉 채움 */
            box-sizing: border-box;  /* 패딩이 너비에 포함되게 함 */
            overflow-y: auto;
            max-height: 200px;
            min-height: 60px;
            margin-bottom: 10px;
            
            padding: 12px;
            background-color: #f8fafc;
            border-radius: 6px;
            color: #64748b;
            font-size: 14px;
            white-space: pre-wrap;
            word-break: break-all;
        }

        /* 혹시라도 강제되고 있을 inline-block 제거 */
        #drawerDetails {
            display: block; 
        }

        .drawer-buttons {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 20px 0;
            text-align: center;
        }

        /* 배지 스타일 */
        .card-badge {
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: bold;
            color: white;
        }
        .badge-success { background-color: #22c55e; }
        .badge-danger { background-color: #ef4444; }

        /* 사이드바 등 기타 요소 */
        aside.open, .sidebar.open, #detailDrawer.open,
        aside.active, .sidebar.active, #detailDrawer.active {
            display: block !important;
            transform: translateX(0) !important;
            right: 0 !important;
            z-index: 9999 !important;
        }
        .material-info-p {
            font-size: 15px; color: #4a5568; line-height: 2;
        }
        .material-info-p strong {
            display: inline-block; width: 75px; color: #1e293b;
        }
    </style>
    <!-- 관리자용 메뉴바 -->
    <t:layout>
        <!-- 상세정보 사이드바 -->
        <t:sidebar>
            <jsp:attribute name="sidebarTitle">
                <span id="drawerSidebarTitle">자재 상세 정보</span>
            </jsp:attribute>
            <jsp:body>
                <!-- 사이드바 내부 전체를 감싸는 컨테이너 -->
                <div class="drawer-container">
                    
                    <div id="drawerImageWrapper" style="display: none; width: 210px; height: 210px; margin: 0 auto; border-radius: 8px; border: 1px solid #dddddd; overflow: hidden; background-color: #ffffff;">
                        <img id="drawerImage" src="" alt="자재 이미지" onerror="this.src='${pageContext.request.contextPath}/resources/images/BS_logo1.svg'" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>

                    <div class="drawer-info-wrap">
                        <div>
                            <hr style="margin: 15px 0; border-top: 1px solid #e2e8f0;">
                            <p class="material-info-p">
                                <strong>유형 : </strong> <span id="drawerMaterialType" style="color: #4a5568; font-weight: bold;">-</span><br>
                                <strong>공급가 :</strong> <span id="drawerSupplyPrice" style="color: #65a30d; font-weight: bold;">0</span>원<br>
                                <strong>상태 :</strong> <span id="drawerStatus" class="badge">상태 정보</span>
                            </p>
                            <hr style="margin: 15px 0; border-top: 1px solid #e2e8f0;">
                            <div class="material-info-p">
                                <p class="material-info-p" style="margin-bottom: 5px;"><strong>상세정보 :</strong></p>
                                <div id="drawerDetails" class="drawer-scroll-content">
                                    <!-- 데이터 주입 구역 -->
                                </div>
                            </div>

                            <!-- 하단 고정 버튼 -->
                            <div class="drawer-buttons">
                                <button type="button" class="button-secondary" id="btnEditMaterial">수정하기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </jsp:body>
        </t:sidebar>
        <!-- 전체 목록 리스트 영역 -->
        <div class="all-list">
            <h1>자재 목록 조회</h1>
            <br>

            <form class="search-form"
                    action="${pageContext.request.contextPath}/admin/materials"
                    method="get">

                    <div class="search-area">

                        <select name="materialType" onchange="this.form.submit()">
                            <option value="" ${empty param.materialType ? 'selected' : ''}>모두보기</option>
                            <option value="AF" ${param.materialType eq 'AF' ? 'selected' : ''}>상온식품</option>
                            <option value="RF" ${param.materialType eq 'RF' ? 'selected' : ''}>냉장식품</option>
                            <option value="FF" ${param.materialType eq 'FF' ? 'selected' : ''}>냉동식품</option>
                            <option value="PK" ${param.materialType eq 'PK' ? 'selected' : ''}>포장재</option>
                            <option value="KW" ${param.materialType eq 'KW' ? 'selected' : ''}>주방용품</option>
                            <option value="ET" ${param.materialType eq 'ET' ? 'selected' : ''}>기타</option>
                        </select>

                        <div class="search-box">

                            <input type="text"
                                name="keyword"
                                placeholder="자재명 검색"
                                value="${param.keyword}">

                            <button type="submit"
                                    class="search-btn">

                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-search-icon lucide-search"><path d="m21 21-4.34-4.34"/><circle cx="11" cy="11" r="8"/></svg>

                            </button>

                        </div>

                        <a class="reset-btn btn btn-danger btn-sm"href="${pageContext.request.contextPath}/admin/materials">
                            초기화
                        </a>

                    </div>

                </form>
            <c:forEach var="targetType" items="${['AF', 'RF', 'FF', 'PK', 'KW', 'ET']}">
                
                <c:set var="hasItem" value="false" />
                <c:forEach var="check" items="${materials}">
                    <c:if test="${check.materialType eq targetType}">
                        <c:set var="hasItem" value="true" />
                    </c:if>
                </c:forEach>
                
                <c:if test="${hasItem}">
                    <div class="category-section">
                        <h2 class="category-title">
                            <c:choose>
                                <c:when test="${targetType eq 'AF'}">상온식품</c:when>
                                <c:when test="${targetType eq 'RF'}">냉장식품</c:when>
                                <c:when test="${targetType eq 'FF'}">냉동식품</c:when>
                                <c:when test="${targetType eq 'PK'}">포장재</c:when>
                                <c:when test="${targetType eq 'KW'}">주방용품</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </h2>
                        
                        <div class="product-grid">
                            <c:forEach var="m" items="${materials}">
                                <c:if test="${m.materialType eq targetType}">
                                    <div class="img-wrap"
                                         onclick="MaterialDrawer.getDetail('${m.materialId}', '${m.materialName}')"
                                         data-details="${m.details}">
                                        <b>${m.materialName}</b>
                                        <c:choose>
                                            <c:when test="${not empty m.materialFiles}">
                                                <img src="${pageContext.request.contextPath}/material-files/${m.materialFiles[0].storedName}" 
                                                    alt="${m.materialName}"
                                                    onerror="this.src='${pageContext.request.contextPath}/resources/images/BS_logo1.svg'">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/resources/images/BS_logo1.svg" 
                                                    alt="${m.materialName}">
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <div class="card-info">
                                            
                                            <span style="color: #65a30d; font-weight: bold; font-size: 15px;">
                                                <fmt:formatNumber value="${m.supplyPrice}" pattern="#,###" />원
                                            </span>
                                            <span class="card-badge ${m.status eq 'ACTIVE' ? 'badge-success' : 'badge-danger'}">
                                                ${m.status eq 'ACTIVE' ? '판매중' : '판매 중단'}
                                            </span>
                                        
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                
            </c:forEach>
        </div>
            
        <script>
            const materialData = [
                <c:forEach items="${materials}" var="m" varStatus="vs">
                    {
                        id: "${m.materialId}",
                        name: "${m.materialName}",
                        type: "${m.materialType}",
                        price: "${m.supplyPrice}",
                        status: "${m.status}",
                        storedName: "${not empty m.materialFiles ? m.materialFiles[0].storedName : ''}"
                    }${!vs.last ? ',' : ''}
                </c:forEach>
            ];
            
                const MaterialDrawer = {
                contextPath: "",

                init: function(contextPath) {
                    this.contextPath = contextPath;
                },

                switchDetailFields: function(type) { 
                    const allTextareas = document.querySelectorAll('.detail-box');
                    allTextareas.forEach(el => el.style.display = 'none');
                    
                    const targetBox = document.getElementById('detail-' + type);
                    if (targetBox) targetBox.style.display = 'block';
                },

                getDetail: function(materialId, name) {
                    // materialData 재사용
                    // 1. materialData 가져오기
                    const el = event.currentTarget;
                    const details = el.getAttribute('data-details');
                    const material = materialData.find(m => m.id == materialId);
                    
                    // 2. 사이드바 타이틀 및 기본 정보 바인딩
                    if (name) {
                        document.getElementById('drawerSidebarTitle').innerHTML = name;
                    }

                    // 3. 이미지, 유형, 가격, 상태를 material 객체 정보로 세팅
                    if (material) {
                        // 이미지 세팅
                        const imgEl = document.getElementById('drawerImage');
                        const wrapperEl = document.getElementById('drawerImageWrapper');
                        if (imgEl && wrapperEl) {
                            imgEl.src = material.storedName ? (this.contextPath + '/material-files/' + material.storedName) : (this.contextPath + "/resources/images/BS_logo1.svg");
                            wrapperEl.style.display = 'block';
                        }

                        // 유형 한글화 매핑
                        const typeMap = { 'AF': '상온식품', 'RF': '냉장식품', 'FF': '냉동식품', 'PK': '포장재', 'KW': '주방용품', 'ET': '기타' };
                        document.getElementById('drawerMaterialType').innerHTML = typeMap[material.type] || material.type;
                        
                        // 가격, 상태
                        document.getElementById('drawerSupplyPrice').innerHTML = Number(material.price).toLocaleString();
                        
                        const statusEl = document.getElementById('drawerStatus');
                        statusEl.innerHTML = (material.status === 'ACTIVE') ? '판매중' : '판매 중단';
                        statusEl.className = (material.status === 'ACTIVE') ? 'card-badge badge-success' : 'card-badge badge-danger';
                        
                        // 이벤트 바인딩 (수정 버튼)
                        this.bindEvents(materialId);
                    }

                    document.getElementById('drawerDetails').innerHTML = '불러오는 중...';

                    $.ajax({
                        
                        url: this.contextPath + "/admin/materials/" + materialId + "/details",
                        type: "GET",
                        success: (details) => {
                            document.getElementById('drawerDetails').innerHTML = details;
                            this.open(); 
                        },
                        error: (xhr, status, error) => {
                            console.error("오류 발생: " + error);
                            alert("상세정보를 불러오는데 실패했습니다.");
                        }
                    });
                },

                bindEvents: function(materialId) {
                    const editBtn = document.getElementById('btnEditMaterial');
                    if (editBtn) {
                        editBtn.onclick = () => {
                            window.location.href = this.contextPath + "/admin/materials/" + materialId + "/edit";
                        };
                    }
                },

                open: function() {
                    if (typeof openSidebar === 'function') {
                        openSidebar();
                    } else {
                        const drawer = document.getElementById('detailDrawer') 
                                    || document.querySelector('aside') 
                                    || document.querySelector('.sidebar');
                        if(drawer) {
                            drawer.classList.add('open');
                            drawer.classList.add('active');
                        }
                    }
                }
            };
        </script>
        
        <script>
            MaterialDrawer.init("${pageContext.request.contextPath}");
        </script>
    </t:layout>