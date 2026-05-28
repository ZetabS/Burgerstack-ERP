<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 점포 등록</title>
</head>
<body>
    <main class="store-enroll-wrap">
        
        <h1>점포 신규 등록</h1>

        <form action="insertStore" method="post">
            <section class="form-section">
                <h2 class="form-title">점포 등록</h2>

                <div class="form-row">
                    <label for="storeName">점포명</label>
                    <input type="text" id="storeName" name="storeName" required>
                </div>

                <div class="form-row">
                    <label for="storeTel">연락처</label>
                    <input type="text" id="storeTel" name="storeTel">
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

                <div class="form-row">
                    <label for="ownerId">점주 아이디</label>
                    <input type="button" id="ownerId" name="ownerId">
                </div>

                <div class="form-row">
                    <label for="ownerName">점주명</label>
                    <input type="button" id="ownerName" name="ownerName" readonly>
                </div>

                <div class="form-row">
                    <label for="ownerPhone">연락처</label>
                    <input type="button" id="ownerPhone" name="ownerPhone" readonly>
                </div>

                <div class="form-row">
                    <label for="ownerEmail">이메일</label>
                    <input type="button" id="ownerEmail" name="ownerEmail readonly">
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

                        <option value="n">
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
                <button type="button">
                    목록으로
                </button>
                <button type="reset">
                    초기화
                </button>
            </div>


        </form>
    </main>
</body>
</html>