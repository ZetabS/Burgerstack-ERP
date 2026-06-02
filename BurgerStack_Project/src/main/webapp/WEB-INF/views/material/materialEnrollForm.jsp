<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS -->
<style>
    .outer {
        border : 1px solid lightgray;
        height : 100%;
        width : 50%;
        margin : auto;
    }
    #detail-area input, #detail-area select {
        margin : 5px;
        width : 250px;
    }
    
    #material-detail {
        margin : 5px;
        width : 250px;
        height : 150px;
        resize: none;
    }
    .material-detail {
        white-space: pre-wrap;
        word-break: break-all; /* 너무 긴 영문 텍스트가 있을 때 영역을 벗어나지 않도록 방지 */
    }
    #materialType {
        padding : 2px 0px 2px 0px;
    }
</style>
</head>
<body> 
    <!-- 자재 등록 페이지 -->

    <t:menubarHO>
        <div class="outer">
            <br>
            <h2 style="padding-left : 20px;"><b>자재 신규 등록</b></h2>
            <hr>
            <!-- 
                파일, 자재명, 유형, 원가, 판매가, 상세정보, 등록자 아이디
                
            -->
            <form action="/burgerstack/material/insert" method="post"
                  enctype="multipart/form-data">

                <input type="hidden" name="createdBy" value="관리자">

                <div id="img-area" onclick="" align="center">
                    <div id="imagePreviewContainer" onclick="document.getElementById('fileInput').click();" style="width: 300px; height: 300px; border: 2px dashed #ccc; display: flex; align-items: center; justify-content: center; cursor: pointer; overflow: hidden; margin: 0 auto 20px;">
                        <span id="uploadText" style="color: #888;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="44" height="44" viewBox="0 0 24 24" fill="none" stroke="#888888" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-image-plus-icon lucide-image-plus"><path d="M16 5h6"/><path d="M19 2v6"/><path d="M21 11.5V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h7.5"/><path d="m21 15-3.086-3.086a2 2 0 0 0-2.828 0L6 21"/><circle cx="9" cy="9" r="2"/></svg>
                            <br>
                            클릭해서 사진 등록
                        </span>
                        <img id="imagePreview" src="" alt="자재 이미지" style="width: 100%; height: 100%; object-fit: cover; display: none;">
                    </div>
                    <input type="file" id="fileInput" name="materialImage"
                           accept="image/*" style="display: none;"
                           onchange="previewImage(this)">
                </div>

                <hr>

                <div align="center">
                    <table id="detail-area">
                        <tr>
                            <th>자재명</th>
                            <td>
                                <input type="text" name="materialName" required>
                            </td>
                        </tr>
                        <tr>
                            <th>유형</th>
                            <td>
                                <select id="materialType" name="materialType">
                                    <option value="RF">냉장식품</option>
                                    <option value="FF">냉동식품</option>
                                    <option value="AF">상온식품</option>
                                    <option value="PK">포장재</option>
                                    <option value="KW">주방용품</option>
                                    <option value="ET">기타</option>
                                    <option value="NULL" selected>----------- 유형 선택 -----------</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>원가</th>
                            <td>
                                <input type="text" name="costPrice" required>
                            </td>
                        </tr>
                        <tr>
                            <th>판매가</th>
                            <td>
                                <input type="text" name="sellingPrice">
                            </td>
                        </tr>
                        <tr>
                            <th>상세정보</th>
                            <td>
                                <textarea id="material-detail" name="details" required></textarea>
                            </td>
                        </tr>
                    </table>
                </div>

                <br>
                
                <div align="center">
                    <button class="button-primary" type="submit">등록하기</button>
                    <button class="button-danger" type="reset">초기화</button>
                </div>
                <br>
            </form>
        </div>
    </t:menubarHO>
    <script>
        function previewImage(input) {
            const file = input.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function(e) {
                const preview = document.getElementById("imagePreview");
                const uploadText = document.getElementById("uploadText");

                preview.src = e.target.result;
                preview.style.display = "block";
                uploadText.style.display = "none";
            };
            reader.readAsDataURL(file);
        }
    </script>    
    
</body>
</html>