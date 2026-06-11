<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BurgerStack</title>
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>
<style>
.outer {
    border : none !important;
    width : 100%;
    max-width : 950px;
    margin : 0 auto;
    box-sizing : border-box;
}
.table-area {
    table-layout : fixed;
    width : 100%;
    max-width : 950px;
    margin : 0 auto;
}
.table-area th {
    width : 120px;
    vertical-align : middle;
}
.table-area td {
    width : calc(100% - 120px);
}
.table-area td>input {
    border : 1px solid #cccccc;
    width : 100%;
    max-width : 800px;
    resize : none;
    padding : 5px 10px;
    box-sizing : border-box;
}
.ql-toolbar.ql-snow {
    max-width: 800px;
    border: 1px solid #cccccc !important;
}
#editor-container {
    border : 1px solid #cccccc !important;
    width : 100%;
    max-width : 800px;
    height : 340px;
    box-sizing : border-box;
    background: white;
}
#file-list-container {
    border : 1px solid #cccccc;
    height : 65px;
    overflow-y : auto;
    padding : 5px;
    box-sizing : border-box;
}
</style>
</head>
<body>
    <t:layout>
        <div class="outer">
            <br>
            <h2 style="padding-left : 20px;">
                <b>공지사항 ${not empty notice ? '수정' : '등록'}</b>
            </h2>

            <c:choose>
                <c:when test="${not empty notice}">
                    <c:url var="formAction" value="/admin/notices/${notice.noticeId}" />
                </c:when>
                <c:otherwise>
                    <c:url var="formAction" value="/admin/notices" />
                </c:otherwise>
            </c:choose>

            <form id="noticeForm" action="${formAction}" method="post" enctype="multipart/form-data">
                <c:if test="${not empty notice}">
                    <input type="hidden" name="noticeId" value="${notice.noticeId}">
                    <%-- 수정 시 POST 오버라이드 (PUT 대신 POST + _method 방식도 가능하나 현재 구조상 POST 그대로) --%>
                </c:if>

                <div align="center">
                    <table class="table table-area">
                        <tr>
                            <th>제목</th>
                            <td>
                                <input type="text" name="title" value="${notice.title}" required>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <%-- ✅ 수정 시 기존 내용을 data 속성으로 안전하게 전달 (JS 백틱 안에 EL 쓰면 특수문자 충돌) --%>
                                <div id="editor-container" data-content="${notice.content}"></div>
                                <input type="hidden" name="content" id="server-content">
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <input type="file" id="notice-files" name="files" multiple accept=".txt, image/*"
                                       style="border : none;" onchange="handleFileSelect(event)">
                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td>
                                <%-- 수정 시: 기존 첨부파일 목록 표시 --%>
                                <div id="file-list-container">
                                    <c:forEach items="${notice.fileList}" var="file">
                                        <div class="file-item" style="display:flex; align-items:center; margin:5px 0;">
                                            <span>${file.originalName}</span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div align="center">
                    <c:choose>
                        <c:when test="${not empty notice}">
                            <button class="button-danger" type="button" onclick="history.back();">취소하기</button>
                        </c:when>
                        <c:otherwise>
                            <button class="button-danger" type="reset">초기화</button>
                        </c:otherwise>
                    </c:choose>
                    <button class="button-primary" type="submit">
                        ${not empty notice ? '수정완료' : '등록하기'}
                    </button>
                </div>
            </form>
        </div>
    </t:layout>

    <script>
        // 1. Quill 초기화
        const quill = new Quill('#editor-container', {
            theme: 'snow',
            modules: {
                toolbar: [
                    [{ 'header': [1, 2, 3, false] }],
                    ['bold', 'italic', 'underline', 'strike'],
                    ['image', 'code-block']
                ]
            }
        });

        // ✅ 수정 시: data 속성에서 기존 내용을 안전하게 로드
        const savedContent = document.getElementById('editor-container').dataset.content;
        if (savedContent && savedContent.trim() !== '') {
            quill.root.innerHTML = savedContent;
        }

        // 2. 이미지 업로드 핸들러 (서버 저장 + 세션 보관)
        quill.getModule('toolbar').addHandler('image', () => {
            const input = document.createElement('input');
            input.setAttribute('type', 'file');
            input.setAttribute('accept', 'image/*');
            input.click();

            input.onchange = async () => {
                const file = input.files[0];
                if (!file) return;

                const formData = new FormData();
                formData.append('image', file);

                try {
                    const response = await fetch('${pageContext.request.contextPath}/admin/notices/uploadImage', {
                        method: 'POST',
                        body: formData
                    });
                    const result = await response.json();

                    if (result.uploaded) {
                        const range = quill.getSelection();
                        quill.insertEmbed(range.index, 'image', result.url);
                    } else {
                        alert('이미지 업로드에 실패했습니다.');
                    }
                } catch (error) {
                    console.error('Error uploading image:', error);
                }
            };
        });

        // ✅ 3. submit 이벤트 핸들러는 하나만 (중복 제거)
        document.getElementById('noticeForm').addEventListener('submit', function() {
            document.getElementById('server-content').value = quill.root.innerHTML;
        });

        // --- 일반 파일 첨부 로직 ---
        let uploadedFiles = [];
        let fileIdCounter = 0;

        function handleFileSelect(event) {
            const files = Array.from(event.target.files);
            files.forEach(file => {
                file.fileId = 'file_' + fileIdCounter++;
                uploadedFiles.push(file);
            });
            renderFileList();
        }

        function renderFileList() {
            const fileListDiv = document.getElementById('file-list-container');
            // 수정 시 기존 파일 목록(JSP로 렌더된 것)은 건드리지 않고, 새로 추가된 것만 append
            // 등록 모드에서는 전체 재렌더
            const isEditMode = ${not empty notice ? 'true' : 'false'};
            if (!isEditMode) {
                fileListDiv.innerHTML = '';
            } else {
                // 수정 모드: JS로 추가된 항목만 제거 후 다시 그림
                fileListDiv.querySelectorAll('.js-file-item').forEach(el => el.remove());
            }

            uploadedFiles.forEach((file) => {
                const fileItem = document.createElement('div');
                fileItem.className = 'js-file-item';
                fileItem.style.cssText = 'display:flex; align-items:center; margin:5px 0;';

                const nameSpan = document.createElement('span');
                nameSpan.textContent = (file.type.startsWith('image/') ? "🖼️ " : "📄 ") + file.name;

                const deleteBtn = document.createElement('button');
                deleteBtn.textContent = 'X';
                deleteBtn.type = 'button';
                deleteBtn.style.cssText = 'margin-left:10px; color:red; border:none; background:none; cursor:pointer; font-weight:bold;';
                deleteBtn.onclick = function() {
                    uploadedFiles = uploadedFiles.filter(f => f.fileId !== file.fileId);
                    renderFileList();
                };

                fileItem.appendChild(nameSpan);
                fileItem.appendChild(deleteBtn);
                fileListDiv.appendChild(fileItem);
            });
            syncInputFiles();
        }

        function syncInputFiles() {
            const dataTransfer = new DataTransfer();
            uploadedFiles.forEach(file => dataTransfer.items.add(file));
            document.getElementById('notice-files').files = dataTransfer.files;
        }

        document.getElementById('noticeForm').addEventListener('reset', function() {
            quill.setContents([]);
            uploadedFiles = [];
            document.getElementById('file-list-container').innerHTML = '';
            document.getElementById('notice-files').value = '';
        });
    </script>
</body>
</html>
