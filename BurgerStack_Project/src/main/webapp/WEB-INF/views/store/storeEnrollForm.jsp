<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 점포 등록</title>
<style>
	.content {
		width : 100%;
		padding-top: 35px;
	}

	.content h1 {
		width: 1300px;
		margin: 0 auto 35px auto;
		font-size: 30px;
		font-weight: bold;
	}

	/* 검색 영역 */
	.search-area {
		width: 1300px;
		margin: 0 auto 15px auto;
		display: flex;
		justify-content: flex-end;
		align-items: center;
		gap: 8px;
	}

	.search-area select {
		width: 100px;
		height: 30px;
		border: 1px solid black;
		border-radius: 15px;
		padding-left: 10px;
	}

	.search-area input[type="date"]{
		height: 30px;
		border: 1px solid black;
		padding: 0 8px;
	}

	.search-box {
		display: flex;
		height: 30px;
	}

	.search-box input {
		width: 130px;
		border: 1px solid black;
		border-right: none;
		padding-left: 10px;
	}

	.search-btn {
		width: 35px;
		height: 30px;
		padding: 0;
		border: none;
		background-color: #60758f;

		display: flex;
		justify-content: center;
		align-items: center;

		cursor: pointer;
	}

	.search-btn img {
		width: 35px;
		height: 30px;
		display: block;
		object-fit: contain;
	}

	/* 테이블 */
	table {
		width: 1300px;
		margin: 0 auto;
		border-collapse: collapse;
		background-color: white;
		text-align: center;
		font-size: 13px;
	}

	thead tr {
		background-color: #19c765;
		height: 35px;
	}

	th {
		padding: 10px;
	}

	tbody tr {
		height: 38px;
		border-bottom: 1px solid #f1f1f1;
		cursor: pointer;
	}

	tbody tr:hover {
    	background-color: #f2f6ff;
	}

</style>
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
			
			        <input type="hidden" id="ownerUserId" name="ownerUserId" value="1">
			
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
			    if(keyword === "owner02") {
				    html += `
				        <div class="owner-item"
				             onclick="selectOwner(1, '김철수')">
				            owner02 / 김철수
				        </div>
				    `;
				}

			    document.getElementById("ownerResultArea").innerHTML = html;
			}
				
				function selectOwner(ownerUserId, ownerName) {
				    document.getElementById("ownerUserId").value = ownerUserId;
	
				    document.getElementById("selectedOwner").value =
				        ownerUserId + " / " + ownerName;
	
				    alert(ownerName + " 점주 계정이 연동되었습니다.");
				}
			
			</script>

</body>
</html>