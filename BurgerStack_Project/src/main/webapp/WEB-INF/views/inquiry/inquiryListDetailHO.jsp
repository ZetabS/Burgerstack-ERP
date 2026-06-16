<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="datetime" uri="/WEB-INF/tld/datetime.tld"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common"%>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table"%>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--
  상세 페이지 패턴 예제입니다.

  기본 구조:
  1. <layout:Page>는 상세/폼처럼 자유롭게 본문을 조립하는 페이지 래퍼입니다.
  2. <layout:Page>에서 actions 슬롯을 쓰면 반드시 <jsp:body>를 명시합니다.
     JSP 컴파일러가 jsp:attribute 뒤의 본문을 안정적으로 해석하도록 하기 위한 정책입니다.
  3. 상세의 라벨/값 영역은 layout:Section + common:FieldList + layout:FieldRow 조합을 사용합니다.
  4. 상세 하단에 관련 목록이 있으면 layout:TableSection + table:Table 조합을 사용합니다.

  필요한 taglib 지시어:
  - layout 컴포넌트: <%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
  - common 컴포넌트: <%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
  - table 컴포넌트: <%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
  - display 컴포넌트: <%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

  모델 예시:
  - detail : 상세 DTO
  - detail.history : 상세 화면 안에 같이 보여줄 이력 목록 DTO
--%>

<%--
  c:url은 context-path(/burgerstack)를 자동으로 붙여줍니다.
  따라서 value에는 /burgerstack을 직접 쓰지 않습니다.
--%>
<c:url var="listUrl" value="/admin/inquiries" />

<%--
  수정 URL에 사용할 문의번호를 준비합니다.

  상세 Mapper에서 INQUIRY_ID를 조회하지 않으면 inquiry.inquiryId가 비어 있을 수 있습니다.
  그래서 먼저 inquiry.inquiryId를 사용하고, 비어 있으면 PathVariable로 넘어온 inquiryId를 사용합니다.
--%>
<c:set var="currentInquiryId" value="${inquiry.inquiryId}" />

<c:if test="${empty currentInquiryId}">
	<c:set var="currentInquiryId" value="${inquiryId}" />
</c:if>

<%--
  최종 수정 페이지 URL입니다.
  최종 결과 예시:
  /burgerstack/admin/inquiries/9/edit
--%>
<c:url var="formUrl" value="/admin/inquiries/${currentInquiryId}/edit" />
<t:layout>
	<layout:Page title="문의사항 상세 페이지" description="">

		<jsp:attribute name="actions">
      <%-- 헤더 오른쪽에는 목록 복귀, 수정 이동 같은 페이지 단위 액션을 둡니다. --%>
      <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>
      <a href="${formUrl}" class="btn btn-primary ml-2"><c:choose>
					<c:when test="${empty inquiry.answeredAt}">답변</c:when>
					<c:otherwise>수정</c:otherwise>
				</c:choose></a>
    </jsp:attribute>

		<jsp:body>
      <layout:Section title="문의사항" description="${inquiry.title}">
        <common:FieldList>

          <%-- 단순 텍스트 값은 FieldRow body에 바로 출력합니다. --%>
          <layout:FieldRow label="문의 등록일">
            <c:out value="${fn:replace(inquiry.createdAt, 'T', ' ')}" />
          </layout:FieldRow>
          <layout:FieldRow label="문의 내용">${inquiry.content}</layout:FieldRow>
        </common:FieldList>
      </layout:Section>
      
            <layout:Section title="문의사항 답변" description="">
        <common:FieldList>
          <layout:FieldRow label="답변 등록일">
            <c:out value="${fn:replace(inquiry.answeredAt, 'T', ' ')}" />
          </layout:FieldRow>

          <%-- 답변 등록일 --%>
          <layout:FieldRow label="답변 등록일">
            <c:choose>
              <c:when test="${empty inquiry.answeredAt}">
                <span class="answer-content">아직 등록된 답변이 없습니다.</span>
              </c:when>
              <c:otherwise>
                <c:out
									value="${fn:replace(inquiry.answeredAt, 'T', ' ')}" />
              </c:otherwise>
            </c:choose>
          </layout:FieldRow>

          <%-- 답변 내용 --%>
          <layout:FieldRow label="답변">
            <c:choose>
              <c:when test="${empty inquiry.answerContent}">
                <span class="answer-content">아직 등록된 답변이 없습니다.</span>
              </c:when>
              <c:otherwise>
                <c:out value="${inquiry.answerContent}" />
              </c:otherwise>
            </c:choose>
          </layout:FieldRow>

        </common:FieldList>
      </layout:Section>
      
    </jsp:body>
	</layout:Page>
</t:layout>
