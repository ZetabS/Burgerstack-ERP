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

<c:url var="baseUrl" value="/burgerstack/admin/inquiries" />
<c:url var="bUrl" value="/burgerstack/admin/dashboard" />

<t:layout>
  <layout:ListPage title="문의사항 목록 페이지" description="">
    <jsp:attribute name="actions">
      <%-- actions 슬롯은 페이지 헤더 오른쪽에 배치됩니다. 초기화, 등록, 다운로드 같은 페이지 단위 액션을 둡니다. --%>
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
        <input type="hidden" name="size" value="${view.pageInfo.size}" />

        <layout:Toolbar>
          <jsp:attribute name="left">
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
            <th class="text-right">점포명</th>
            <th class="text-right">등록일</th>
            <th class="text-center">답변상태</th>
          </tr>
        </jsp:attribute>

        <jsp:attribute name="tbody">
          <c:forEach var="inq" items="${inquiryList}">
            <c:url var="detailUrl" value="${pageContext.request.contextPath}/admin/inquiries/${inq.inquiryId}" />
            <c:url var="formUrl" value="/example/patterns/form" />
            <c:set var="inquiryStatus" value="${empty inq.answerContent ? 'REQUESTED' : 'ANSWERED'}"></c:set>

            <%--
              TableRow에 clickable과 href를 주면 행 클릭 이동을 위한 data 속성이 붙습니다.
              버튼 셀과 함께 쓰는 경우에는 행 클릭 정책이 업무 화면과 충돌하지 않는지 확인하세요.
            --%>
            <table:TableRow clickable="true" href="${detailUrl}">
              <table:TextFitCell value="${inq.inquiryId}" />
              <table:TextCell value="${inq.title}" />
              <table:TextCell value="${inq.storeName}" />
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