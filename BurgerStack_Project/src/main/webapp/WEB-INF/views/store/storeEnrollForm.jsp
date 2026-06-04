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
    .store-enroll-wrap {
        width: 1300px;
        margin: 0 auto;
        padding-top: 35px;
    }

    .store-enroll-wrap h1 {
        margin-bottom: 35px;
        font-size: 30px;
        font-weight: bold;
    }

    .form-section {
        margin-bottom: 35px;
        padding: 25px;
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 12px;
    }

    .form-title,
    .form-section h2 {
        margin-bottom: 20px;
        font-size: 22px;
        font-weight: bold;
        border-left: 5px solid #19c765;
        padding-left: 12px;
    }

    .form-row {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }

    .form-row label {
        width: 130px;
        font-weight: bold;
    }

    .form-row input,
    .form-row select {
        width: 400px;
        height: 38px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 0 10px;
    }

    .form-row button {
        height: 38px;
        margin-left: 8px;
        padding: 0 15px;
        border: none;
        border-radius: 6px;
        background: #19c765;
        color: white;
        cursor: pointer;
    }

    #ownerResultArea {
        min-height: 38px;
        width: 400px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 8px 10px;
    }

    .owner-item {
        cursor: pointer;
        padding: 5px;
    }

    .owner-item:hover {
        background: #f2f6ff;
    }

    .btn-area {
        text-align: center;
        margin-top: 30px;
    }

    .btn-area button {
        width: 120px;
        height: 40px;
        margin: 0 5px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        font-weight: bold;
    }

    .btn-area button[type="submit"] {
        background: #19c765;
        color: white;
    }

    .btn-area button[type="button"] {
        background: #374151;
        color: white;
    }

    .btn-area button[type="reset"] {
        background: white;
        color: #ef4444;
        border: 1px solid #ef4444;
    }
</style>
</head>

<body>

<t:menubarHO>

    <main class="store-enroll-wrap">

        <h1>점포 신규 등록</h1>

        <form action="${pageContext.request.contextPath}/admin/stores" method="post">

            <section class="form-section">
                <h2 class="form-title">점포 등록</h2>

                <div class="form-row">
                    <label for="storeName">점포명</label>
                    <input type="text" id="storeName" name="storeName" required>
                </div>

                <div class="form-row">
                    <label for="phone">연락처</label>
                    <input type="text" id="phone" name="phone">
                </div>

                <div class="form-row">
                    <label for="address">주소</label>
                    <input type="text" id="address" name="address" required>
                </div>

                <div class="form-row">
                    <label for="storeDetailAddress">상세주소</label>
                    <input type="text" id="storeDetailAddress" name="storeDetailAddress">
                </div>
            </section>

            <section class="form-section">
                <h2>점주 계정 연결</h2>

                <div class="form-row">
                    <label for="searchOwnerId">점주 검색</label>

                    <input type="text"
                           id="searchOwnerId"
                           placeholder="점주 아이디 입력">

                    <button type="button" onclick="searchOwner()">검색</button>
                </div>

                <div class="form-row">
                    <label>검색 결과</label>
                    <div id="ownerResultArea">
                        검색 결과가 여기에 표시됩니다.
                    </div>
                </div>

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
                        <option value="Y">현재 재고 기준 재고 생성</option>
                        <option value="N">생성 안함</option>
                    </select>
                </div>
            </section>

            <div class="btn-area">
                <button type="submit">등록</button>

                <button type="button"
                        onclick="location.href='${pageContext.request.contextPath}/store/list'">
                    목록으로
                </button>

                <button type="reset">초기화</button>
            </div>

        </form>

    </main>

</t:menubarHO>

	<script>
	function searchOwner() {
	    const keyword = document.getElementById("searchOwnerId").value;
	
	    if (keyword.trim() === "") {
	        alert("점주 아이디를 입력하세요.");
	        return;
	    }
	
	    let html = "";
	
	    if (keyword === "owner02") {
	        html += `
	            <div class="owner-item" onclick="selectOwner(1, '김철수')">
	                owner02 / 김철수
	            </div>
	        `;
	    } else {
	        html = "검색 결과가 없습니다.";
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