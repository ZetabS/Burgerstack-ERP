<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BurgerStack</title>
    <style>
        .all-list {
            margin: auto; padding: 15px; width: 80%;
        }
        .category-section {
            margin-bottom: 40px;
        }
        .category-title {
            margin: 20px; border-bottom: 2px solid #ddd; padding-bottom: 10px;
        }
        
        /* 이미지 카드 그리드 배치 보완 */
        .product-grid { 
            display: flex; 
            flex-wrap: wrap; 
            gap: 20px; 
            padding: 0 20px; 
        }
        
        /* 이미지 카드 디자인 */
        .product-grid .img-wrap {
            width: 200px;
            height: 240px;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 8px 10px 10px 10px;
            background-color: #fff;
            text-align: center;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            overflow: hidden; 
            box-shadow: 0 2px 6px rgba(0,0,0,0.04);
            transition: transform 0.1s, box-shadow 0.1s;
        }

        .product-grid .img-wrap:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .product-grid .img-wrap b {
            font-size: 13px;
            line-height: 1.3;
            color: #1e293b;
            display: block;
            width: 100%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-bottom: 4px;
            word-break: break-all;
        }
        .product-grid .img-wrap br {
           display: none !important;
        }

        /* 사진 가득 차게 고정 */
        .product-grid .img-wrap img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 8px;
            margin-top: auto;
        }
        
        aside.open, .sidebar.open, #detailDrawer.open,
        aside.active, .sidebar.active, #detailDrawer.active {
            display: block !important;
            transform: translateX(0) !important;
            right: 0 !important;
            z-index: 9999 !important;
        }
        .material-info-p {
            font-size: 15px;
            color: #4a5568;
            line-height: 2;
        }
        .material-info-p strong {
            display: inline-block;
            width: 75px;
            color: #1e293b;
        }
    </style>
</head>
<body> 
    <!-- 관리자용 메뉴바 -->
    <t:menubarHO>
        <!-- 상세정보 사이드바 -->
        <t:sidebar>
            <jsp:attribute name="sidebarTitle">
                <span id="drawerSidebarTitle">자재 상세 정보</span>
            </jsp:attribute>
            <jsp:body>
                <br>
                <div id="drawerImageWrapper" style="display: none; width: 210px; height: 210px; margin: 0 auto; border-radius: 8px; border: 1px solid #dddddd; overflow: hidden; background-color: #ffffff;">
                    <img id="drawerImage"
                        src=""
                        alt="자재 이미지"
                        onerror="this.src='${pageContext.request.contextPath}/resources/images/BS_logo1.svg'"
                        style="width: 100%; height: 100%; object-fit: cover;">
                </div>
                <br>
                
                <div class="drawer-info-wrap" style="width: 80%; margin: 0 auto;">
                
                    <hr style="margin: 15px 0; border-top: 1px solid #e2e8f0;">
                    
                    <!-- 공급가, 상태 정보 영역 -->
                    <p class="material-info-p">
                        <strong>공급가 :</strong> <span id="drawerSupplyPrice" style="color: #65a30d; font-weight: bold;">0</span>원<br>
                        <strong>상태 :</strong> <span id="drawerStatus" class="badge">상태 정보</span>
                    </p>
                    
                    <hr style="margin: 15px 0; border-top: 1px solid #e2e8f0;">
                    
                    <!-- 상세정보 타이틀 및 본문 영역 -->
                    <p class="material-info-p" style="margin-bottom: 5px;"><strong>상세정보 :</strong></p>
                    <div id="drawerDetails" style="background-color: #f8fafc; padding: 12px; border-radius: 6px; color: #64748b; min-height: 60px; font-size: 14px; white-space: pre-wrap; word-break: break-all;">
                        <!-- 데이터 주입 구역 -->
                    </div>
                    
                    <br><br>
                    <div align="center">
                        <button type="button" class="button-secondary" id="btnEditMaterial">
                            수정하기
                        </button>
                        <button type="button" class="button-danger" id="btnDeleteMaterial">
                            삭제하기
                        </button>
                    </div>
                </div>
            </jsp:body>
        </t:sidebar>

        <!-- 전체 목록 리스트 영역 -->
        <div class="all-list">
            <h1>자재 목록 조회</h1>
            <br>

            <c:forEach var="targetType" items="AF,RF,FF,PK,KW,ET">
                
                <c:set var="hasItem" value="false" />
                <c:forEach var="check" items="${materials}">
                    <c:if test="${check.materialType eq targetType}">
                        <c:set var="hasItem" value="true" />
                    </c:if>
                </c:forEach>
                
                <c:if var="displaySection" test="${hasItem}">
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
                                    <div class="img-wrap" onclick="MaterialDrawer.getDetail('${m.materialId}', '${m.materialName}')" style="cursor: pointer;">
                                        <b>${m.materialName}</b><br>
                                        <c:choose>
                                            <c:when test="${not empty m.materialFiles}">
                                                <img src="${pageContext.request.contextPath}/material-files/${m.materialFiles[0].storedName}"
                                                    alt="${m.materialName}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/resources/images/BS_logo1.svg"
                                                    alt="${m.materialName}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                
            </c:forEach>
        </div>
    </t:menubarHO>

    <script>
        const MaterialDrawer = {
            contextPath: "",

            init: function(contextPath) {
                this.contextPath = contextPath;
            },

            getDetail: function(materialId, name) {
                if (name) {
                    const titleEl = document.getElementById('drawerSidebarTitle');
                    if (titleEl) titleEl.innerHTML = name;
                }

                $.ajax({
                    url: this.contextPath + "/admin/materials/detail",
                    type: "GET",
                    data: { materialId: materialId },
                    dataType: "json",
                    success: (data) => {
                        this.bindData(data);
                        this.bindEvents(materialId);
                        this.open();
                    },
                    error: (xhr, status, error) => {
                        alert("자재 정보를 가져오는데 실패했습니다. (Error: " + xhr.status + ")");
                        console.error(error);
                    }
                });
            },

            bindData: function(data) {
                // 1. 이미지
                const imgEl = document.getElementById('drawerImage');
                const wrapperEl = document.getElementById('drawerImageWrapper');
                
                if (imgEl && wrapperEl) {
                    const fallback = this.contextPath + "/resources/images/BS_logo1.svg";
                    if (data.materialFiles && data.materialFiles.length > 0) {
                        const firstFile = data.materialFiles[0];
                        imgEl.src = this.contextPath + '/material-files/' + firstFile.storedName;
                    } else {
                        imgEl.src = fallback;
                    }
                    
                    wrapperEl.style.display = 'block';
                }

                // 2. 공급가
                const supplyPriceEl = document.getElementById('drawerSupplyPrice');
                if (supplyPriceEl) {
                    supplyPriceEl.innerHTML = data.supplyPrice ? Number(data.supplyPrice).toLocaleString() : '0';
                }

                // 3. 상태
                const statusEl = document.getElementById('drawerStatus');
                if (statusEl) {
                    if (data.status === 'ACTIVE') {
                        statusEl.innerHTML = '판매중';
                        statusEl.className = 'badge badge-success';
                    } else {
                        statusEl.innerHTML = data.status ? data.status : '중단';
                        statusEl.className = 'badge badge-danger';
                    }
                }

                // 4. 상세정보
                const detailsEl = document.getElementById('drawerDetails');
                if (detailsEl) {
                    detailsEl.innerHTML = data.details ? data.details : '등록된 자재 설명이 없습니다.';
                }
            },

            bindEvents: function(materialId) {
                const editBtn = document.getElementById('btnEditMaterial');
                if (editBtn) {
                    editBtn.onclick = () => {
                        window.location.href = this.contextPath + "/admin/materials/" + materialId + "/edit";
                    };
                }

                const deleteBtn = document.getElementById('btnDeleteMaterial');
                if (deleteBtn) {
                    deleteBtn.onclick = () => {
                        this.deleteMaterial(materialId);
                    };
                }
            },

            deleteMaterial: function(materialId) {
                if (confirm("정말 삭제하시겠습니까?")) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = this.contextPath + '/admin/materials/' + materialId + '/status';
                    document.body.appendChild(form);
                    form.submit();
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
    
</body>
</html>