<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${empty title ? 'BurgerStack ERP' : title}</title>
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
        word-break: break-all;
    }
    #materialType {
        padding : 2px 0px 2px 0px;
    }
</style>
</head>
<body> 
    <t:menubarHO>
        <div class="outer">
            <br>
            <h2 style="padding-left : 20px;">
                <b>자재 ${not empty material ? '정보 수정' : '신규 등록'}</b>
            </h2>
            <hr>
            <c:choose>
                <c:when test="${not empty material}">
                    <!-- 수정 모드일 때 -->
                    <c:url var="formAction" value="/admin/materials/${material.materialId}" />
                </c:when>
                <c:otherwise>
                    <!-- 신규 등록 모드일 때 -->
                    <c:url var="formAction" value="/admin/materials" />
                </c:otherwise>
            </c:choose>
            <form action="${formAction}" method="post" enctype="multipart/form-data">

                <c:if test="${not empty material}">
                    <input type="hidden" name="materialId" value="${material.materialId}">
                </c:if>

                <input type="hidden" name="createdBy" value="1">

                <div id="img-area" align="center">
                    <div id="imagePreviewContainer" onclick="document.getElementById('fileInput').click();" 
                        style="width: 300px; height: 300px; border: 2px dashed #ccc; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; overflow: hidden; margin: 0 auto 20px; position: relative; background-color: #fff;">
                        
                        <!-- 등록된 사진 없을 때(수정/신규) -->
                        <span id="uploadText" style="color: #888; text-align: center; ${not empty material.materialFiles ? 'display: none;' : 'display: block;'}">
                            <svg xmlns="http://www.w3.org/2000/svg" width="44" height="44" viewBox="0 0 24 24" fill="none" stroke="#888888" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-image-plus-icon lucide-image-plus"><path d="M16 5h6"/><path d="M19 2v6"/><path d="M21 11.5V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h7.5"/><path d="m21 15-3.086-3.086a2 2 0 0 0-2.828 0L6 21"/><circle cx="9" cy="9" r="2"/></svg>
                            <br>
                            클릭해서 사진 등록
                        </span>
                        
                        <!-- 등록된 사진 있을 때(수정) -->
                        <img id="imagePreview"
                            src="${not empty material.materialFiles
                                    ? pageContext.request.contextPath.concat('/material-files/').concat(material.materialFiles[0].storedName)
                                    : ''}"
                            alt="자재 이미지"
                            style="width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0; ${not empty material.materialFiles ? 'display: block;' : 'display: none;'}">
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
                                <input type="text" name="materialName" value="${material.materialName}" required>
                            </td>
                        </tr>
                        <tr>
                            <th>유형</th>
                            <td>
                                <select id="materialType" name="materialType">
                                    <option value="RF" ${material.materialType == 'RF' ? 'selected' : ''}>냉장식품</option>
                                    <option value="FF" ${material.materialType == 'FF' ? 'selected' : ''}>냉동식품</option>
                                    <option value="AF" ${material.materialType == 'AF' ? 'selected' : ''}>상온식품</option>
                                    <option value="PK" ${material.materialType == 'PK' ? 'selected' : ''}>포장재</option>
                                    <option value="KW" ${material.materialType == 'KW' ? 'selected' : ''}>주방용품</option>
                                    <option value="ET" ${material.materialType == 'ET' ? 'selected' : ''}>기타</option>
                                    <option value="NULL" ${empty material ? 'selected' : ''}>----------- 유형 선택 -----------</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>공급가</th>
                            <td>
                                <input type="text" name="supplyPrice" value="${material.supplyPrice}" required>
                            </td>
                        </tr>
                        <tr>
                            <th>상세정보</th>
                            <td>
                                <textarea id="material-detail" name="details" required>${material.details}</textarea>
                            </td>
                        </tr>
                    </table>
                </div>

                <br>
                
                <div align="center">
                    <button class="button-primary" type="submit">
                        ${not empty material ? '수정완료' : '등록하기'}
                    </button>
                    
                    <c:choose>
                        <c:when test="${not empty material}">
                            <button class="button-danger" type="button" onclick="history.back();">취소하기</button>
                        </c:when>
                        <c:otherwise>
                            <button class="button-danger" type="reset">초기화</button>
                        </c:otherwise>
                    </c:choose>
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