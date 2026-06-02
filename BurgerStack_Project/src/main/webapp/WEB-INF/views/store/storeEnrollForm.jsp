<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 점포 등록</title>
</head>
<body>
<t:menubarHO>
    <main class="store-enroll-wrap">
        
        <h1>점포 신규 등록</h1>

		
        <form action="${pageContext.request.contextPath}/store/insertStore" method="post">
            <section class="form-section">
                <h2 class="form-title">점포 등록</h2>

                <div class="form-row">
                    <label for="storeName">점포명</label>
                    <input type="text" id="storeName" name="storeName" required>
                </div>

                <div class="form-row">
                    <label for="storePhone">연락처</label>
                    <input type="text" id="storePhone" name="storePhone">
                </div>

                <div class="form-row">
                    <label for="storeAddress">주소</label>
                    <input type="text" id="storeAddress" name="storeAddress">
                </div>

                <div class="form-row">
                    <label for="storeDetailAddress">(상세주소)</label>
                    <input type="text" id="storeDetailAddress" name="storeDetailAddress">
                </div>
            </section>

            <section class="form-section">

			    <h2>점주 계정 연결</h2>
			
			    <!-- 검색 -->
			    <div class="form-row">
			        <label for="searchOwnerId">점주 검색</label>
			
			        <input type="text"
			               id="searchOwnerId"
			               placeholder="점주 아이디 입력">
			
			        <button type="button" onclick="searchOwner()">
			            검색
			        </button>
			    </div>
			
			    <!-- 검색 결과 -->
			    <div class="form-row">
			        <label>검색 결과</label>
			
			        <div id="ownerResultArea">
			
			            <!-- 예시 -->
			            <!--
			            <div class="owner-item"
			                 onclick="selectOwner('hong123', '홍길동')">
			
			                hong123 / 홍길동
			            </div>
			            -->
			
			        </div>
			    </div>
			
			    <!-- 실제 등록될 값 -->
			    <div class="form-row">
			        <label>선택된 점주</label>
			
			        <input type="hidden"
			               id="ownerId"
			               name="ownerId">
			
			        <input type="text"
			               id="selectedOwner"
			               readonly
			               placeholder="선택된 점주 없음">
			    </div>
			
			</section>

            <section class="form-section">

                <h2>점포 재고 생성</h2>

                <div class="form-row">
                    <label for="createStockYn">재고 생성 여부</label>
                    
                    <select id="createStockYn" name="createStockYn">
                        <option value="Y">
                            현재 재고 기준 재고 생성
                        </option>

                        <option value="N">
                            생성 안함
                        </option>
                    </select>
                </div>
            </section>

            <!-- 버튼 생성 -->
            <div class="btn-area">
                <button type="submit">
                    등록
                </button>
                <button type="button"
				        onclick="location.href='${pageContext.request.contextPath}/store/list'">
				    	목록으로
				</button>
                <button type="reset">
                    초기화
                </button>
            </div>


        </form>
    </main>
	</t:menubarHO>
			<script>

			function searchOwner() {

			    const keyword =
			        document.getElementById("searchOwnerId").value;

			    if(keyword.trim() === "") {

			        alert("점주 아이디를 입력하세요.");
			        return;
			    }

			    let html = "";

			    // 아이디 기준 검색
			    if(keyword === "hong123") {

			        html += `
			            <div class="owner-item"
			                 onclick="selectOwner('hong123', '홍길동')">

			                hong123 / 홍길동
			            </div>
			        `;
			    }

			    document.getElementById("ownerResultArea").innerHTML = html;
			}
				
				function selectOwner(ownerId, ownerName) {
				
				    document.getElementById("ownerId").value = ownerId;
				
				    document.getElementById("selectedOwner").value =
				        ownerId + " / " + ownerName;
				
				    alert(ownerName + " 점주 계정이 연동되었습니다.");
				}
			
			</script>

</body>
</html>