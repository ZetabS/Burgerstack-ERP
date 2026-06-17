<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
    <t:layout>
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

                <div id="img-area" align="center">
                    <div id="imagePreviewContainer" onclick="document.getElementById('fileInput').click();"
                        style="width: 250px; height: 250px; border: 2px dashed #ccc; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; overflow: hidden; margin: 0 auto 20px; position: relative; background-color: #fff;">

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
                                <select id="materialType" name="materialType" required>
                                    <option value="" disabled ${empty material ? 'selected' : ''} hidden>----------- 유형 선택 -----------</option>
                                    <option value="AF" ${material.materialType == 'AF' ? 'selected' : ''}>상온식품</option>
                                    <option value="RF" ${material.materialType == 'RF' ? 'selected' : ''}>냉장식품</option>
                                    <option value="FF" ${material.materialType == 'FF' ? 'selected' : ''}>냉동식품</option>
                                    <option value="PK" ${material.materialType == 'PK' ? 'selected' : ''}>포장재</option>
                                    <option value="KW" ${material.materialType == 'KW' ? 'selected' : ''}>주방용품</option>
                                    <option value="ET" ${material.materialType == 'ET' ? 'selected' : ''}>기타</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>공급가</th>
                            <td>
                                <input type="text" name="supplyPrice"
                                       value="${not empty material.supplyPrice ? material.supplyPrice : '0'}"
                                       pattern="^[0-9]+$"
                                       oninput="this.value = this.value.replace(/[^0-9]/g, '')"
                                       required>
                            </td>
                        </tr>
                        <tr>
                            <th>상태</th>
                            <td>
                                <select id="status" name="status">
                                    <option value="ACTIVE" ${material.status eq 'ACTIVE' || empty material ? 'selected' : ''}>판매중</option>
                                    <option value="INACTIVE" ${material.status eq 'INACTIVE' ? 'selected' : ''}>판매 중단</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>상세정보</th>
                            <td>
                                <div class="material-info-p">
                                    <textarea name="details" id="material-detail" maxlength="800"
                                              oninput="checkLength(this)"><c:out value="${material.details}" /></textarea>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div> <!-- 양식 -->

                <div align="center">
                    <button class="button-secondary" type="button" onclick="location.href='${pageContext.request.contextPath}/admin/materials'">
                        목록으로
                    </button>
                    <button class="button-danger" type="reset">
                        초기화
                    </button>
                    <button class="button-primary" type="submit">
                        ${not empty material ? "수정완료" : "등록하기"}
                    </button>
                </div>
                <br>
            </form>
        </div>
        <script>

            // 텍스트 길이 체크
            function checkLength(el) {
                const maxLength = el.getAttribute('maxlength');
                const currentLength = el.value.length;
            }

            // 파일 확장자 화이트리스트 검증
            document.getElementById('fileInput').addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (!file) return;

                // 허용할 이미지 확장자 리스트
                const allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
                const fileName = file.name.toLowerCase();
                const extension = fileName.substring(fileName.lastIndexOf('.') + 1);

                if (!allowedExtensions.includes(extension)) {
                    alert("이미지 파일(jpg, jpeg, png, gif, webp)만 업로드 가능합니다.");
                    this.value = ''; // 선택된 파일 초기화
                    document.getElementById("imagePreview").style.display = "none";
                    document.getElementById("uploadText").style.display = "block";
                    return;
                }

                previewImage(this);
            });

            // 이미지 프리뷰
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

            // textarea : 유형 선택에 따른 양식 출력
            // 각 유형별 양식 정의 (객체로 관리)
            const templates = {
                'AF': '중량 : \n원재료명 : ',
                'RF': '중량 : \n원재료명 : ',
                'FF': '중량 : \n원재료명 : ',
                'PK': '재질 : \n사이즈 : 가로 × 세로 × 높이 (mm)',
                'KW': '브랜드 : \n상품명 : ',
                'ET': ''
            };

            // 유형 선택 시 실행
            document.getElementById('materialType').addEventListener('change', function() {
                const textarea = document.getElementById('material-detail');
                const selectedType = this.value;

                // 내용이 비어있거나 기존 양식인 경우에만 덮어쓰기 (사용자 입력 보호)
                if (textarea.value.trim() === '' || Object.values(templates).includes(textarea.value)) {
                    textarea.value = templates[selectedType] || '';
                }
            });

            window.onload = function() {
                const textarea = document.getElementById('material-detail');
                if (textarea.value) {
                    textarea.value = textarea.value.replace(/&#40;/g, '(').replace(/&#41;/g, ')');
                }
            };
        </script>
    </t:layout>

