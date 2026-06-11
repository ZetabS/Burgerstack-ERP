<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BurgerStack</title>
<%-- Quill snow CSS: 에디터로 작성된 HTML이 상세보기에서도 동일하게 보이도록 --%>
<link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet">
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
    border-collapse: collapse;
}
.table-area td {
    padding: 12px 15px;
    border-bottom: 1px solid #eeeeee;
    text-align: left;
    width : calc(100% - 120px);
    vertical-align : middle;
}
#notice-content {
    width : 100%;
    max-width : 100%;
    overflow-y : auto;
    overflow-x : hidden;
    min-height : 340px;
    box-sizing : border-box;
    line-height: 1.6;
    white-space: normal;
    word-break: break-all;
    overflow-wrap: break-word;
}
#notice-content img {
    max-width : 100%;
    height : auto;
    display : inline-block;
    vertical-align : middle;
}
#file-list-container {
    border : 1px solid #cccccc;
    width: 100%;
    height : 75px;
    overflow-y : auto;
    padding : 8px 12px;
    box-sizing : border-box;
    background-color: #fafafa;
}
.file-item a {
    display: inline-block;
    padding: 2px 0;
    transition: color 0.2s;
}
.file-item a:hover {
    color: #16a34a !important;
    text-decoration: underline !important;
}
</style>
</head>
<body>
    <t:layout>
        <div class="outer">
            <br>
            <h2 style="padding-left : 20px;">
                <b>공지사항</b>
            </h2>

            <div>
                <table class="table table-area">

                    <tr>
                        <td><b>${notice.title}</b></td>
                    </tr>

                    <tr>
                        <td>
                            <div id="notice-content">
                                <%-- escapeXml을 false로 설정하여 HTML 태그가 정상적으로 렌더링되도록 합니다 --%>
                                <c:out value="${notice.content}" escapeXml="false" />
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <b>첨부파일</b><br>
                            <div id="file-list-container">
                                <c:forEach items="${notice.fileList}" var="file">
                                    <c:set var="fileName" value="${fn:toLowerCase(file.originalName)}" />
                                    
                                    <div class="file-item" style="margin-bottom: 5px;">
                                        <a href="${pageContext.request.contextPath}/admin/notices/download?noticeFileId=${file.noticeFileId}"
                                        style="color: #22C55E; text-decoration: none;">
                                            📁 ${file.originalName}
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </td>
                    </tr>

                </table>
            </div>

            <div align="center">
                <!-- 1. 수정하기: 단순 GET 이동 -->
                <button type="button" class="button-secondary" 
                        onclick="location.href='${pageContext.request.contextPath}/admin/notices/${notice.noticeId}/edit'">
                    수정하기
                </button>

                <!-- 2. 목록으로: GET 이동 -->
                <button type="button" class="button-primary" 
                        onclick="location.href='${pageContext.request.contextPath}/admin/notices'">
                    목록으로
                </button>

                <!-- 3. 삭제하기: POST 방식 전송을 위한 form -->
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/notices/${notice.noticeId}/delete" method="post" style="display:inline;">
                    <button type="button" class="button-danger" onclick="confirmDelete()">
                        삭제하기
                    </button>
                </form>
            </div>
        </div>

        <script>
            function confirmDelete() {
                if (confirm("정말로 삭제하시겠습니까?")) {
                    document.getElementById('deleteForm').submit();
                }
            }
        </script>
        <script>
            // 페이지 로드 시 기존 내용 삽입
            const quill = new Quill('#editor', { ... });
            const content = `${notice.content}`; 
            quill.root.innerHTML = content;
            
            // 폼 제출 전 content 숨겨진 input에 값 넣기
            document.querySelector('form').onsubmit = function() {
                document.getElementById('content').value = quill.root.innerHTML;
            };
        </script>
    </t:layout>
</body>
</html>
