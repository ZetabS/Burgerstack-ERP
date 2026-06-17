<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
    padding : 0 20px;
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
    height : 70px;
    overflow-y : scroll;
    padding : 5px;
    box-sizing : border-box;
    max-width: 800px;
}
</style>
    <t:layout>
        <div class="outer">
            <br>
            <h2 style="padding-left : 20px;">
                <b>공지사항 ${not empty notice ? '수정' : '등록'}</b>
                <hr>
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
                    <table class="table-area">
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
                                <div id="editor-container"></div>
                                <textarea id="saved-content" style="display:none;" maxlength="800"><c:out value="${notice.content}" escapeXml="false"/></textarea>
                                <input type="hidden" name="content" id="server-content">
                            </td>
                        </tr>
                        <tr>
                            <th></th>
                            <td>
                                <br>
                                <%-- input file은 새 파일 추가 전용. DB 파일은 아래 div에 직접 렌더 --%>
                                <input type="file" id="notice-files" name="files" multiple accept=".txt, image/*"
                                       style="border : none;" onchange="handleFileSelect(event)">
                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td>
                                <%-- form 안에 추가: 삭제할 파일 ID를 담을 컨테이너 --%>
                                <div id="delete-file-ids-container"></div>

                                <%-- 첨부파일 목록 td 안 전체 교체 --%>
                                <div id="file-list-container">
                                    <div id="file-upload-guide" style="color : #AAAAAA; font-size : 12px;
                                            ${not empty notice.fileList ? 'display : none;' : ''}">
                                        첨부파일 1개당 크기는 10MB, 최대 5개 까지 업로드 가능합니다. <br>
                                        exe, bat, cmd 등 일부 파일 확장자는 업로드 할 수 없습니다.
                                    </div>
                                    <%-- 수정 모드: DB에서 불러온 기존 파일 직접 렌더 --%>
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
                                        <%-- data-file-id 속성으로 JS에서 삭제 처리 가능하게 --%>
                                        <div class="file-item db-file-item" data-file-id="${file.noticeFileId}"
                                            style="display:flex; align-items:center; margin:4px 0;">
                                            <span><c:out value="${fileIcon} ${file.originalName}" /></span>
                                            <%-- X버튼 추가 --%>
                                            <button type="button"
                                                    style="margin-left:8px; color:red; border:none; background:none; cursor:pointer; font-weight:bold;"
                                                    onclick="removeDbFile(this, ${file.noticeFileId})">X</button>
                                        </div>
                                    </c:forEach>
                                </div>

                            </td>
                        </tr>
                    </table>
                </div>

                <div align="center" style="margin-top: 10px;">
                    <br>
                    <button class="button-secondary" type="button" onclick="location.href='${pageContext.request.contextPath}/admin/notices'">
                        목록으로
                    </button>
                    <button class="button-danger" type="reset">
                        초기화
                    </button>
                    <button class="button-primary" type="submit">
                        ${not empty notice ? "수정완료" : "등록하기"}
                    </button>
                </div>
            </form>
        </div>
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
            const savedContent = document.getElementById('saved-content').value;
            if (savedContent && savedContent.trim() !== '') {
                quill.root.innerHTML = savedContent;
            }

            // ── 2. Quill 이미지 업로드 핸들러 ────────────────────────────
            // ✅ 이미지 업로드 후 파일 리스트에 표시 + X 버튼으로 에디터에서도 동시 제거
            quill.getModule('toolbar').addHandler('image', () => {
                // 업로드 갯수 제한 먼저 체크
                if (getTotalFileCount() >= 5) {
                    alert('첨부파일 및 이미지는 총 5개까지만 업로드 가능합니다.');
                    return;
                }

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
                            updateFileGuideVisibility();
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

                    if(uploadedFiles.length === 0 && document.querySelectorAll('.js-file-item').length === 0) {
                        document.getElementById('file-upload-guide').style.display = 'block';
                    }
                };
                // 파일 추가시 안내 문구 숨기기
                document.getElementById("file-upload-guide").style.display = 'none';

                item.appendChild(delBtn);
                container.appendChild(item);
            }


            // ── 3. submit: 에디터 내용 → hidden input ───────────────────
            document.getElementById('noticeForm').addEventListener('submit', function(e) {
                const htmlContent = quill.root.innerHTML;

                // 바이트 계산 (태그 포함)
                let byteCount = 0;
                for (let i = 0; i < htmlContent.length; i++) {
                    // 한글(2바이트 이상)인지 확인
                    byteCount += (htmlContent.charCodeAt(i) > 127) ? 3 : 1;
                }

                // DB 제한보다 약간 여유 있게 체크
                const DB_LIMIT = 2800; // 태그 오차를 고려해 2800 정도로 설정

                if (byteCount > DB_LIMIT) {
                    alert("내용이 너무 깁니다. (이미지나 서식을 줄여주세요)\n현재 바이트: " + byteCount + " / 3000");
                    e.preventDefault();
                    return;
                }

                document.getElementById('server-content').value = htmlContent;
            });

            // ── 4. 일반 파일 첨부 로직 ──────────────────────────────────
            let uploadedFiles = [];
            let fileIdCounter = 0;

            function handleFileSelect(event) {

                const newFiles = Array.from(event.target.files);
                // 파일 크기, 갯수 제한
                const MAX_SIZE = 10 * 1024 * 1024; // 10MB
                const MAX_COUNT = 5;

                // 통합 개수 검증
                if (getTotalFileCount() + newFiles.length > MAX_COUNT) {
                    alert('첨부파일은 에디터 이미지 포함 최대 ' + MAX_COUNT + '개까지 업로드 가능합니다.');
                    event.target.value = '';
                    return;
                }
                // 화이트/블랙리스트
                const ALLOWED_EXT = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'pdf', 'hwp', 'doc', 'docx', 'txt'];
                const BLOCKED_EXT = ['exe', 'bat', 'cmd', 'sh', 'ps1', 'vbs', 'jsp', 'php', 'asp', 'aspx', 'jar', 'war', 'class', 'msi', 'dll'];

                // 개별 파일 검증
                for (const file of newFiles) {
                    const ext = file.name.split('.').pop().toLowerCase();

                    // 화이트리스트 검증
                    if (!ALLOWED_EXT.includes(ext)) {
                        alert(`허용되지 않은 파일 형식입니다: ${ext}`);
                        event.target.value = '';
                        return;
                    }

                    // 블랙리스트 검증
                    if (BLOCKED_EXT.includes(ext)) {
                        alert(`보안상 업로드할 수 없는 파일입니다: ${ext}`);
                        event.target.value = '';
                        return;
                    }

                    // MIME 타입 검증
                    const isImage = file.type.startsWith('image/');
                    const isDoc = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'text/plain'].includes(file.type);

                    if (!isImage && !isDoc) {
                        alert("이미지 또는 문서 파일만 업로드 가능합니다.");
                        event.target.value = '';
                        return;
                    }

                    // 용량 검증
                    if (file.size > MAX_SIZE) {
                        alert(`파일 크기가 너무 큽니다 (최대 10MB): ${file.name}`);
                        event.target.value = '';
                        return;
                    }
                }

                // 검증 통과 후 추가
                newFiles.forEach(file => {
                    file.fileId = 'file_' + fileIdCounter++;
                    uploadedFiles.push(file);
                    const icon = file.type.startsWith('image/') ? '🖼️' : '📄';
                    addFileItemToList(icon + ' ' + file.name, file.fileId);
                });

                document.getElementById("file-upload-guide").style.display = 'none';
                syncInputFiles();
            }

            // 에디터+파일첨부 통합 갯수 제한
            function getTotalFileCount() {
                const editorImages = quill.root.querySelectorAll('img').length;
                const normalFiles = uploadedFiles.length;
                const dbFiles = document.querySelectorAll('.db-file-item').length; // 기존 DB 파일
                return editorImages + normalFiles + dbFiles;
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

                        if(uploadedFiles.length === 0 && document.querySelectorAll('.js-file-item').length === 0) {
                            document.getElementById('file-upload-guide').style.display = 'block';
                        }
                    };
                    item.appendChild(delBtn);
                }

                container.appendChild(item);
                updateFileGuideVisibility();
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

            function removeDbFile(btn, fileId) {
                // 화면에서 제거
                btn.closest('.db-file-item').remove();

                // ✅ 삭제할 파일 ID를 hidden input으로 누적
                const container = document.getElementById('delete-file-ids-container');
                const hidden = document.createElement('input');
                hidden.type = 'hidden';
                hidden.name = 'deleteFileIds';
                hidden.value = fileId;
                container.appendChild(hidden);

                updateFileGuideVisibility();
            }

            /**
             * 파일 목록(신규+기존)이 비어있는지 확인하고 안내 문구 토글
             */
            function updateFileGuideVisibility() {
                const guide = document.getElementById('file-upload-guide');
                const hasNewFiles = uploadedFiles.length > 0;
                const hasJsFiles = document.querySelectorAll('.js-file-item').length > 0;
                const hasDbFiles = document.querySelectorAll('.db-file-item').length > 0;

                // 하나라도 파일이 있으면 가이드 숨김
                if (hasNewFiles || hasJsFiles || hasDbFiles) {
                    guide.style.display = 'none';
                } else {
                    guide.style.display = 'block';
                }
            }

        </script>
    </t:layout>
