<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
.table-area div {
    
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
    min-height : 45px;
    max-height: 120px;
    overflow-y : auto;
    padding : 8px 12px;
    box-sizing : border-box;
    background-color: #fafafa;
}
.file-item a {
    display: inline-block;
    padding: 2px 0;
    color: #22C55E;
    text-decoration: none;
    transition: color 0.2s;
}
.file-item a:hover {
    color: #16a34a !important;
    text-decoration: underline !important;
}
</style>
    <t:layout>
        <div class="outer">
            <br>
            <h2 style="padding-left : 20px;">
                <b>공지사항</b>
            </h2>

            <div>
                <table class="table table-area">

                    <tr>
                        <td><b>　${notice.title}</b></td>
                        <td style="text-align: right; padding : auto;">
                            ${notice.detailDate}
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <div id="notice-content" class="ql-editor">
                                <c:out value="${notice.content}" escapeXml="false" />
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <b>첨부파일</b>
                            <br><br>
                            <div id="file-list-container">
                                <c:if test="${empty notice.fileList}">
                                    <span style="color: #999; font-size: 14px;">첨부된 파일이 없습니다.</span>
                                </c:if>

                                <c:forEach items="${notice.fileList}" var="file">
                                    <c:set var="lowerName" value="${fn:toLowerCase(file.originalName)}" />
                                    <c:set var="isImage" value="${fn:endsWith(lowerName,'.jpg') || fn:endsWith(lowerName,'.jpeg') || fn:endsWith(lowerName,'.png') || fn:endsWith(lowerName,'.gif') || fn:endsWith(lowerName,'.webp')}" />

                                    <div class="file-item" style="margin-bottom: 6px;">
                                        <c:choose>
                                            <%-- ✅ 이미지 파일: img 썸네일 제거, 아이콘+링크만 --%>
                                            <c:when test="${isImage}">
                                                <a href="${pageContext.request.contextPath}/admin/notices/download?noticeFileId=${file.noticeFileId}">
                                                    🖼️ ${file.originalName}
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/admin/notices/download?noticeFileId=${file.noticeFileId}">
                                                    📄 ${file.originalName}
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                        </td>
                    </tr>

                </table>
            </div>

            <div align="center" style="margin-top: 15px;">
                <button type="button" class="button-secondary"
                        onclick="location.href='${pageContext.request.contextPath}/admin/notices/${notice.noticeId}/edit'">
                    수정하기
                </button>
                <button type="button" class="button-primary"
                        onclick="location.href='${pageContext.request.contextPath}/admin/notices'">
                    목록으로
                </button>
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/notices/${notice.noticeId}/delete" method="post" style="display:inline;">
                    <button type="button" class="button-danger" onclick="confirmDelete()">
                        삭제하기
                    </button>
                </form>
            </div>
        </div>

        <%-- ✅ 상세보기에는 Quill 에디터 불필요 — 스크립트 제거 --%>
        <script>
            function confirmDelete() {
                if (confirm("정말로 삭제하시겠습니까?")) {
                    document.getElementById('deleteForm').submit();
                }
            }
        </script>
    </t:layout>