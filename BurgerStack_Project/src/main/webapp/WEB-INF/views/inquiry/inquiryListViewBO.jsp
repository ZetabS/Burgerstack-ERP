<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

<%--
  목록 페이지 패턴 예제입니다.

  이 파일은 실제 업무 화면을 만들 때 복사해서 출발점으로 삼을 수 있도록 상세 주석을 남겨둡니다.

  기본 구조:
  1. <t:layout>은 기존 애플리케이션 전체 레이아웃입니다. 이 prefix는 기존 루트 태그 디렉터리를 그대로 사용합니다.
  2. <layout:ListPage>는 디자인 시스템의 목록 페이지 전용 래퍼입니다.
     - PageHeader를 강제합니다.
     - toolbar, table, pagination 슬롯을 명시적으로 분리합니다.
     - 목록 화면에서 카드/헤더/본문 구조를 매번 직접 만들지 않도록 합니다.
  3. <layout:Toolbar>는 좌측 필터 영역과 우측 검색 영역을 분리합니다.
  4. <table:Table>은 thead/tbody만 받아 데이터 테이블 정책을 일괄 적용합니다.

  필요한 taglib 지시어:
  - layout 컴포넌트: <%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
  - common 컴포넌트: <%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
  - table 컴포넌트: <%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
  - display 컴포넌트: <%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

  모델 예시:
  - view.condition : 검색 조건 DTO. 컨트롤러가 request parameter를 받아 그대로 넣어야 툴바 값이 현재 검색 조건과 동기화됩니다.
  - view.materialTypes : select option 후보 목록
  - view.list : 현재 페이지의 행 DTO 목록
  - view.pageInfo : <t:pagination>에 전달할 PageInfo
--%>

<%--
  c:url은 context-path(/burgerstack)를 자동으로 붙여줍니다.
  그래서 value에는 /burgerstack을 직접 쓰지 않고, 실제 Controller 매핑 경로만 작성합니다.
--%>
<c:url var="baseUrl" value="/owner/inquiries" />
<c:url var="bUrl" value="/owner/dashboard" />

<t:layout>
  <layout:ListPage title="문의사항 목록 페이지" description="">

    <jsp:attribute name="actions">
      <%-- actions 슬롯은 페이지 헤더 오른쪽에 배치됩니다. 초기화, 등록, 다운로드 같은 페이지 단위 액션을 둡니다. --%>
      <%-- 목록 페이지에서 이전으로 버튼을 누르면 점주 대시보드로 이동합니다. --%>
      <a href="${bUrl}" class="btn btn-secondary">이전으로</a>
    </jsp:attribute>

    <jsp:attribute name="toolbar">
      <%--
        toolbar 슬롯에는 보통 GET 검색 폼을 둡니다.

        폼은 layout:Toolbar 바깥에 둡니다.
        이렇게 하면 select, checkbox, search input이 모두 같은 querystring으로 제출됩니다.
      --%>
      <form action="${baseUrl}" method="get">

        <%-- 검색 조건이 바뀌면 1페이지부터 다시 조회하는 것이 목록 UX의 기본입니다. --%>
        <input type="hidden" name="page" value="1" />

        <%--
          size는 한 페이지에 보여줄 행 개수입니다.
          view.pageInfo.size 값이 있을 경우 기존 페이지 크기를 유지합니다.
        --%>
        <input type="hidden" name="size" value="${view.pageInfo.size}" />

        <layout:Toolbar>
          <jsp:attribute name="left">

            <%--
              점주 문의사항 목록은 문의 필터를 사용하지 않습니다.
              관리자 문의사항 목록 페이지에서만 답변전/답변완료 필터를 사용합니다.

              이 select는 검색 기준을 선택합니다.
              - title     : 제목 검색
              - content   : 내용 검색
              - inquiryId : 글번호 검색
            --%>
		     <%-- 문의 필터 --%>
			  <%-- onchange="this.form.submit();" : 답변전/답변완료/전체 선택 시 검색 버튼 없이 바로 조회됩니다. --%>
			  <select name="answerStatus" class="form-control mr-2" onchange="this.form.submit();">
			
			      <%-- 처음 목록 진입 시 보여줄 placeholder --%>
			      <option value="" disabled hidden
			          ${empty answerStatus ? 'selected' : ''}>
			          문의 필터
			      </option>
			
			      <%-- 전체 조회 --%>
			      <option value="ALL"
			          ${answerStatus == 'ALL' ? 'selected' : ''}>
			          전체
			      </option>
			
			      <%-- 답변 전 문의만 조회 --%>
			      <option value="REQUESTED"
			          ${answerStatus == 'REQUESTED' ? 'selected' : ''}>
			          문의
			      </option>
			
			      <%-- 답변 완료 문의만 조회 --%>
			      <option value="ANSWERED"
			          ${answerStatus == 'ANSWERED' ? 'selected' : ''}>
			          답변완료
			      </option>
			  </select>
			
			  <%-- 검색 조건 --%>
			  <select name="condition" class="form-control mr-2">
			
			      <option value="title"
			          ${condition == 'title' ? 'selected' : ''}>
			          제목
			      </option>
			
			      <option value="content"
			          ${condition == 'content' ? 'selected' : ''}>
			          내용
			      </option>
			
			      <option value="inquiryId"
			          ${condition == 'inquiryId' ? 'selected' : ''}>
			          글번호
			      </option>
			
			  </select>
			  
			</jsp:attribute>

          <jsp:attribute name="right">          
            <%--
              right 슬롯은 검색바나 주요 보조 액션을 둡니다.
              SearchBar는 input-group과 submit 버튼 조합만 표준화합니다.

              name="keyword"로 전달된 검색어는 Controller에서 keyword로 받습니다.
            --%>
            <common:SearchBar name="keyword" value="${keyword}" placeholder="검색" />
          </jsp:attribute>
        </layout:Toolbar>
      </form>
    </jsp:attribute>

    <jsp:attribute name="table">
      <%--
        table:Table은 thead와 tbody를 명시적으로 받습니다.
        isEmpty를 넘기면 tbody 대신 emptyMessage가 표시됩니다.
      --%>
      <table:Table isEmpty="${empty inquiryList}" emptyMessage="조회된 문의사항이 없습니다.">

        <jsp:attribute name="thead">
          <tr>
            <th class="text-center">No</th>
            <th class="text-right">제목</th>
            <th class="text-right">등록일</th>
            <th class="text-center">답변상태</th>
          </tr>
        </jsp:attribute>

        <jsp:attribute name="tbody">
          <%--
            inquiryList는 Controller에서 model.addAttribute("inquiryList", inquiryList)로 전달됩니다.
            각 문의사항 행을 반복 출력합니다.
          --%>
          <c:forEach var="inq" items="${inquiryList}">

            <%--
              문의사항 상세 페이지 URL입니다.
              c:url을 사용하면 context-path가 자동으로 붙습니다.
              최종 URL 예시: /burgerstack/owner/inquiries/1
            --%>
            <c:url var="detailUrl" value="/owner/inquiries/${inq.inquiryId}" />

            <%--
              답변상태 계산입니다.
              answerContent가 비어 있으면 REQUESTED, 값이 있으면 ANSWERED로 판단합니다.
              display:InquiryStatusBadge 태그가 이 값을 받아 배지로 표시합니다.
            --%>
            <c:set var="inquiryStatus" value="${empty inq.answerContent ? 'REQUESTED' : 'ANSWERED'}"></c:set>

            <%--
              TableRow에 clickable과 href를 주면 행 클릭 이동을 위한 data 속성이 붙습니다.
              버튼 셀과 함께 쓰는 경우에는 행 클릭 정책이 업무 화면과 충돌하지 않는지 확인하세요.
            --%>
            <table:TableRow clickable="true" href="${detailUrl}">
              <table:TextFitCell value="${inq.inquiryId}" />
              <table:TextCell value="${inq.title}" />
              <table:DateTimeCell value="${inq.createdAt}" />
              <table:FitCell align="left">
              	<display:InquiryStatusBadge value="${inquiryStatus}"/>
              </table:FitCell>
            </table:TableRow>

          </c:forEach>
        </jsp:attribute>
      </table:Table>
    </jsp:attribute>

    <jsp:attribute name="pagination">
      <%-- 기존 pagination 태그는 루트 t prefix를 유지합니다. PageInfo만 넘기면 됩니다. --%>
      <t:pagination pageInfo="${view.pageInfo}" />
    </jsp:attribute>

  </layout:ListPage>
</t:layout>