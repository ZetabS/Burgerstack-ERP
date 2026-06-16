<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

<c:url var="listUrl" value="/owner/inquiries" />
<c:url var="submitUrl" value="/owner/inquiries/${inquiryId}" />

<t:layout>
  <layout:Page title="문의사항 작성" description="">

    <jsp:body>
    
      <c:set var="isAnswered" value="${not empty inquiry.answerContent}" />

      <form action="${submitUrl}" method="post">
        <input type="hidden" name="inventoryId" value="${inquiry.inquiryId}" />

        <layout:Section title="문의사항을 작성해주세요." description="">
          
          <c:if test="${isAnswered}">
            <div class="alert alert-warning text-center mb-4" role="alert" style="font-weight: bold; font-size: 0.95rem;">
              ⚠️ 본사 답변이 등록된 문의사항은 내용을 수정할 수 없습니다.
            </div>
          </c:if>

          <layout:FieldRow label="제목" inputId="safetyQuantity" help="제목을 입력하시오.">
            <input type="text" class="title" id="title" name="title" maxlength="100" value="${inquiry.title}" required 
                   ${isAnswered ? 'disabled' : ''} />
          </layout:FieldRow>

          <layout:FieldRow label="내용" inputId="memo" help="최대 1000자까지 입력 가능합니다.">
            <textarea class="form-control" id="content" name="content" rows="4" maxlength="1000" 
                      ${isAnswered ? 'disabled' : ''}><c:out value="${inquiry.content}" /></textarea>
          </layout:FieldRow>
        </layout:Section>

        <common:Actions>
          <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>
          
          <c:if test="${not isAnswered}">
            <button type="submit" class="btn btn-primary ml-2">저장</button>
          </c:if>
        </common:Actions>
      </form>
    </jsp:body>
  </layout:Page>
</t:layout>