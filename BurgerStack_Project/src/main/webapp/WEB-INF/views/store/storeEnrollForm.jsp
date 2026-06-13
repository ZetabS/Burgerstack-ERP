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
        width: 1000px;
        margin: 55px auto;
    }

    .store-enroll-wrap h1 {
        margin-bottom: 8px;
        font-size: 32px;
        font-weight: 700;
    }

    .page-desc {
        margin-bottom: 30px;
        color: #6b7280;
        font-size: 14px;
    }

    .form-section {
        margin-bottom: 35px;
        padding: 30px 35px;
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .form-title,
    .form-section h2 {
        margin-bottom: 24px;
        font-size: 22px;
        font-weight: bold;
        border-left: 5px solid #19c765;
        padding-left: 12px;
    }

    .form-row {
        display: flex;
        align-items: center;
        margin-bottom: 16px;
    }

    .form-row label {
        width: 140px;
        font-weight: bold;
        color: #374151;
    }

    .form-row input,
    .form-row select {
        width: 420px;
        height: 38px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 0 10px;
        box-sizing: border-box;
    }

    .phone-group {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .phone-group input {
        width: 120px;
        text-align: center;
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
        font-weight: bold;
    }

    .form-row button:hover {
        background: #16a34a;
    }

    #ownerResultArea {
        min-height: 38px;
        width: 420px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 8px 10px;
        box-sizing: border-box;
        color: #6b7280;
    }

    .owner-item {
        cursor: pointer;
        padding: 7px 8px;
        border-radius: 6px;
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

    .btn-area button[type="submit"]:hover {
        background: #16a34a;
    }

    .btn-area button[type="button"] {
        background: #374151;
        color: white;
    }

    .btn-area button[type="button"]:hover {
        background: #1f2937;
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

<t:layout>

    <main class="store-enroll-wrap">

        <h1>점포 신규 등록</h1>
        <p class="page-desc">
            신규 점포 정보를 입력하고 대표 점주 계정을 연결합니다.
        </p>

        <c:if test="${not empty msg}">
            <script>
                alert("${msg}");
            </script>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/stores"
              method="post"
              onsubmit="return validateStoreEnroll();">

            <section class="form-section">
                <h2 class="form-title">점포 등록</h2>

                <div class="form-row">
                    <label for="storeName">점포명</label>
                    <input type="text"
                           id="storeName"
                           name="storeName"
                           maxlength="50"
                           required>
                </div>

                <div class="form-row">
                    <label>연락처</label>

                    <div class="phone-group">
                        <input type="text"
                               id="phone1"
                               name="phone1"
                               maxlength="3"
                               placeholder="02"
                               required>

                        <span>-</span>

                        <input type="text"
                               id="phone2"
                               name="phone2"
                               maxlength="4"
                               placeholder="1234"
                               required>

                        <span>-</span>

                        <input type="text"
                               id="phone3"
                               name="phone3"
                               maxlength="4"
                               placeholder="5678"
                               required>
                    </div>
                </div>

                <div class="form-row">
                    <label for="address">주소</label>
                    <input type="text"
                           id="address"
                           name="address"
                           maxlength="200"
                           required>
                </div>

                <div class="form-row">
                    <label for="detailAddress">상세주소</label>
                    <input type="text"
                           id="detailAddress"
                           name="detailAddress"
                           maxlength="100"
                           placeholder="상세주소 입력">
                </div>
            </section>

            <section class="form-section">
                <h2>점주 계정 연결</h2>

                <div class="form-row">
                    <label for="searchOwnerId">점주 아이디</label>

                    <input type="text"
                           id="searchOwnerId"
                           placeholder="점주 아이디 입력">

                    <button type="button" onclick="searchOwner()">
                        검색
                    </button>
                </div>

                <div class="form-row">
                    <label>검색 결과</label>
                    <div id="ownerResultArea">
                        점주 아이디를 검색해주세요.
                    </div>
                </div>

                <div class="form-row">
                    <label>선택된 점주</label>

                    <input type="hidden"
                           id="ownerUserNo"
                           name="ownerUserNo">

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
                        <option value="Y">전체 자재 기준 재고 생성</option>
                        <option value="N">생성 안함</option>
                    </select>
                </div>
            </section>

            <div class="btn-area">
                <button type="submit">등록</button>

                <button type="button"
                        onclick="location.href='${pageContext.request.contextPath}/admin/stores'">
                    목록으로
                </button>

                <button type="reset"
                        onclick="clearOwnerResult();">
                    초기화
                </button>
            </div>

        </form>

    </main>

</t:layout>

<script>
    const contextPath = "${pageContext.request.contextPath}";

    function searchOwner() {
        const keyword = document.getElementById("searchOwnerId").value.trim();
        const resultArea = document.getElementById("ownerResultArea");

        clearSelectedOwner();

        if (keyword === "") {
            alert("점주 아이디를 입력하세요.");
            resultArea.innerHTML = "점주 아이디를 검색해주세요.";
            return;
        }

        fetch(contextPath + "/admin/stores/owners/search?keyword=" + encodeURIComponent(keyword))
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (!data.found) {
                    resultArea.innerHTML = "검색 결과가 없습니다.";
                    clearSelectedOwner();
                    return;
                }

                resultArea.innerHTML =
                    "<div class='owner-item' onclick=\"selectOwner('"
                    + data.ownerUserNo + "', '"
                    + data.ownerLoginId + "', '"
                    + data.ownerName + "')\">"
                    + data.ownerLoginId + " / "
                    + data.ownerName
                    + "</div>";
            })
            .catch(function() {
                resultArea.innerHTML = "검색 중 오류가 발생했습니다.";
                clearSelectedOwner();
            });
    }

    function selectOwner(ownerUserNo, ownerLoginId, ownerName) {
        document.getElementById("ownerUserNo").value = ownerUserNo;
        document.getElementById("selectedOwner").value =
            ownerLoginId + " / " + ownerName;

        alert(ownerName + " 점주 계정이 연결되었습니다.");
    }

    function clearSelectedOwner() {
        document.getElementById("ownerUserNo").value = "";
        document.getElementById("selectedOwner").value = "";
    }

    function clearOwnerResult() {
        setTimeout(function() {
            document.getElementById("ownerResultArea").innerHTML =
                "점주 아이디를 검색해주세요.";
            clearSelectedOwner();
        }, 0);
    }

    function validateStoreEnroll() {
        const ownerUserNo = document.getElementById("ownerUserNo").value;

        if (ownerUserNo === "") {
            alert("점주 계정을 검색 후 선택해주세요.");
            document.getElementById("searchOwnerId").focus();
            return false;
        }

        const phone1 = document.getElementById("phone1").value.trim();
        const phone2 = document.getElementById("phone2").value.trim();
        const phone3 = document.getElementById("phone3").value.trim();

        const phoneReg = /^[0-9]+$/;

        if (!phoneReg.test(phone1) || !phoneReg.test(phone2) || !phoneReg.test(phone3)) {
            alert("연락처는 숫자만 입력해주세요.");
            return false;
        }

        return confirm("점포를 등록하시겠습니까?");
    }
</script>

</body>
</html>