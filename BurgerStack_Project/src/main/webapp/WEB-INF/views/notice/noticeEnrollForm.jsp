<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
.table-area td > input[type="text"] {
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
    min-height : 65px;
    overflow-y : auto;
    padding : 5px;
    box-sizing : border-box;
    max-width: 800px;
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
                                <%-- data 속성으로 기존 내용 전달 (JS 백틱 안 EL은 특수문자 충돌 위험) --%>
                                <div id="editor-container" data-content="${notice.content}"></div>
                                <input type="hidden" name="content" id="server-content">
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <%-- input file은 새 파일 추가 전용. DB 파일은 아래 div에 직접 렌더 --%>
                                <input type="file" id="notice-files" name="files" multiple accept=".txt, image/*"
                                       style="border : none;" onchange="handleFileSelect(event)">
                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td>
                                <div id="file-list-container">
                                    <%-- 수정 모드: DB에서 불러온 기존 파일 직접 렌더 (input file 보안 제한 우회) --%>
                                    <c:forEach items="${notice.fileList}" var="file">
                                        <c:set var="lowerName" value="${fn:toLowerCase(file.originalName)}" />
                                        <c:choose>
                                            <c:when test="${fn:endsWith(lowerName,'.jpg') || fn:endsWith(lowerName,'.jpeg') ||
                                                        fn:endsWith(lowerName,'.png') || fn:endsWith(lowerName,'.gif') ||
                                                        fn:endsWith(lowerName,'.webp')}">
                                                <c:set var="fileIcon" value="🖼️" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="fileIcon" value="📄" />
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="file-item db-file-item" style="display:flex; align-items:center; margin:4px 0;">
                                            <span>${fileIcon} ${file.originalName}</span>
                                            <%-- DB 파일은 수정 시 삭제 기능 구현 전까지 표시만 --%>
                                        </div>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div align="center" style="margin-top: 10px;">
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
        // ── 1. Quill 초기화 ──────────────────────────────────────────
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

        // 수정 모드: data 속성에서 기존 내용 로드
        const savedContent = document.getElementById('editor-container').dataset.content;
        if (savedContent && savedContent.trim() !== '') {
            quill.root.innerHTML = savedContent;
        }

        // ── 2. Quill 이미지 업로드 핸들러 ────────────────────────────
        // ✅ 이미지 업로드 후 파일 리스트에 표시 + X 버튼으로 에디터에서도 동시 제거
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
                    const res = await fetch('${pageContext.request.contextPath}/admin/notices/uploadImage', {
                        method: 'POST',
                        body: formData
                    });
                    const result = await res.json();

                    if (result.uploaded) {
                        // 1. 에디터 본문에 이미지 삽입 후 삽입된 위치(index) 저장
                        const range = quill.getSelection();
                        const insertIndex = range ? range.index : quill.getLength();
                        quill.insertEmbed(insertIndex, 'image', result.url);

                        // ✅ 2. 파일 리스트에 표시 + X 버튼 클릭 시 에디터에서도 해당 이미지 제거
                        addQuillImageToList(file.name, result.url);
                    } else {
                        alert('이미지 업로드에 실패했습니다.');
                    }
                } catch (err) {
                    console.error('이미지 업로드 오류:', err);
                }
            };
        });

        /**
         * Quill 이미지 전용 리스트 항목 추가
         * X 버튼 클릭 시 에디터 본문의 해당 src 이미지도 함께 제거
         */
        function addQuillImageToList(fileName, imageUrl) {
            const container = document.getElementById('file-list-container');

            const item = document.createElement('div');
            item.className = 'file-item js-file-item';
            item.style.cssText = 'display:flex; align-items:center; margin:4px 0;';

            const nameSpan = document.createElement('span');
            nameSpan.textContent = '🖼️ ' + fileName;
            item.appendChild(nameSpan);

            // ✅ X 버튼: 클릭 시 에디터 본문에서 해당 이미지 src와 일치하는 img 블롯 제거
            const delBtn = document.createElement('button');
            delBtn.textContent = 'X';
            delBtn.type = 'button';
            delBtn.style.cssText = 'margin-left:8px; color:red; border:none; background:none; cursor:pointer; font-weight:bold;';
            delBtn.onclick = function() {
                // Quill Delta에서 해당 URL의 이미지 찾아서 삭제
                const delta = quill.getContents();
                let idx = 0;
                delta.ops.forEach(op => {
                    if (op.insert && op.insert.image && op.insert.image === imageUrl) {
                        quill.deleteText(idx, 1);
                    }
                    idx += (typeof op.insert === 'string') ? op.insert.length : 1;
                });
                item.remove();
            };
            item.appendChild(delBtn);
            container.appendChild(item);
        }


        // ── 3. submit: 에디터 내용 → hidden input ───────────────────
        document.getElementById('noticeForm').addEventListener('submit', function() {
            document.getElementById('server-content').value = quill.root.innerHTML;
        });

        // ── 4. 일반 파일 첨부 로직 ──────────────────────────────────
        let uploadedFiles = [];
        let fileIdCounter = 0;

        function handleFileSelect(event) {
            Array.from(event.target.files).forEach(file => {
                file.fileId = 'file_' + fileIdCounter++;
                uploadedFiles.push(file);
                const icon = file.type.startsWith('image/') ? '🖼️' : '📄';
                addFileItemToList(icon + ' ' + file.name, file.fileId);
            });
            syncInputFiles();
        }

        /**
         * 파일 리스트 div에 항목 추가
         * @param {string} label  - 표시할 텍스트
         * @param {string} fileId - 'quill' 이면 삭제 버튼 없음, 일반 파일이면 X 버튼 추가
         */
        function addFileItemToList(label, fileId) {
            const container = document.getElementById('file-list-container');

            const item = document.createElement('div');
            item.className = 'file-item js-file-item';
            item.dataset.fileId = fileId;
            item.style.cssText = 'display:flex; align-items:center; margin:4px 0;';

            const nameSpan = document.createElement('span');
            nameSpan.textContent = label;
            item.appendChild(nameSpan);

            // Quill 이미지는 에디터 본문에 포함되므로 삭제 버튼 불필요
            if (fileId !== 'quill') {
                const delBtn = document.createElement('button');
                delBtn.textContent = 'X';
                delBtn.type = 'button';
                delBtn.style.cssText = 'margin-left:8px; color:red; border:none; background:none; cursor:pointer; font-weight:bold;';
                delBtn.onclick = function() {
                    uploadedFiles = uploadedFiles.filter(f => f.fileId !== fileId);
                    item.remove();
                    syncInputFiles();
                };
                item.appendChild(delBtn);
            }

            container.appendChild(item);
        }

        function syncInputFiles() {
            const dt = new DataTransfer();
            uploadedFiles.forEach(f => dt.items.add(f));
            document.getElementById('notice-files').files = dt.files;
        }

        // reset: 에디터 + 파일 목록 + JS 파일 항목 초기화 (DB 파일 항목은 유지)
        document.getElementById('noticeForm').addEventListener('reset', function() {
            quill.setContents([]);
            uploadedFiles = [];
            document.querySelectorAll('.js-file-item').forEach(el => el.remove());
            document.getElementById('notice-files').value = '';
        });
    </script>
</body>
</html>
