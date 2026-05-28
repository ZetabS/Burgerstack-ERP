<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <main class="store-enroll-wrap">
        
        <h1>점포 상세 정보 조회</h1>

        <form action="selectStore" method="post">
            <section class="form-section">
                <h2 class="form-title">점포 정보</h2>

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

            <br>

            <form action="selectManager" method="post">
                <section class="form-section">
                     <h2 class="form-title">점장 정보</h2>

                     <div class="form-row">
                        <label for="managerId">아이디</label>
                        <input type="text" id="managerId" name="managerId" readonly>
                     </div>

                     <div class="form-row">
                        <label for="managerPwd">비밀번호</label>
                        <input type="password" id="managerPwd" name="managerPwd">
                     </div>

                     <div class="form-row">
                        <label for="managerName">이름</label>
                        <input type="text" id="managerName" name="managerName" readonly>
                     </div>

                     <div class="form-row">
                        <label for="managerPhone">연락처</label>
                        <input type="number" id="managerPhone" name="managerPhone" readonly>
                     </div>

                     <div class="form-row">
                        <label for="managerEmail">이메일</label>
                        <input type="text" id="managerEmail" name="managerEmail">
                     </div>
                </section>
            </form>

            <div class="button-group">
                <button type="Update">
                    수정
                </button>
                <button type="button">
                    목록으로
                </button>
            </div>


</body>
</html>