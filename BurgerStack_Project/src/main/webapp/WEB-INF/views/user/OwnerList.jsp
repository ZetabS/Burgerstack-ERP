<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

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
  따라서 value에는 /burgerstack을 직접 쓰지 않습니다.

  최종 URL:
  /burgerstack/admin/users
--%>
<c:url var="baseUrl" value="/admin/users" />

<%--
  이전으로 버튼 URL입니다.

  최종 URL:
  /burgerstack/admin/dashboard
--%>
<c:url var="bUrl" value="/admin/dashboard" />

<t:layout>
  <layout:ListPage title="점주 목록 페이지" description="등록된 점주 계정을 조회할 수 있습니다.">

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

        <%--
          페이지 크기 유지용입니다.
          컨트롤러에서 view.pageInfo.size를 내려주고 있다면 그 값을 그대로 사용합니다.
        --%>
        <input type="hidden" name="size" value="${view.pageInfo.size}" />

        <layout:Toolbar>
          <jsp:attribute name="left">

		    <%--
		      상태 필터입니다.

		      기존 코드에서는 name="condition"으로 되어 있었는데,
		      option 선택 여부는 param.status로 확인하고 있었습니다.

		      그래서 name도 status로 맞춰야 컨트롤러에서 status 파라미터로 받을 수 있습니다.
		    --%>
		    <select name="status" class="form-control mr-2">
		
			    <option value="" ${empty param.status ? 'selected' : ''}>
			        전체상태
			    </option>
			
			    <option value="ACTIVE"
			        ${param.status eq 'ACTIVE' ? 'selected' : ''}>
			        영업중
			    </option>
			
			    <option value="INACTIVE"
			        ${param.status eq 'INACTIVE' ? 'selected' : ''}>
			        폐점
			    </option>
		
		    </select>
            
          </jsp:attribute>

          <jsp:attribute name="right">          
            <%--
              right 슬롯은 검색바나 주요 보조 액션을 둡니다.
              SearchBar는 input-group과 submit 버튼 조합만 표준화합니다.

              점주 목록이므로 검색 placeholder를 점주 목록에 맞게 변경했습니다.
            --%>
            <common:SearchBar name="keyword" value="${keyword}" placeholder="아이디, 점주명 검색" />
          </jsp:attribute>
        </layout:Toolbar>
      </form>
    </jsp:attribute>

    <jsp:attribute name="table">
      <%--
        table:Table은 thead와 tbody를 명시적으로 받습니다.
        isEmpty를 넘기면 tbody 대신 emptyMessage가 표시됩니다.

        기존 emptyMessage가 "조회된 문의사항이 없습니다."였는데,
        이 페이지는 점주 목록 페이지이므로 점주 기준 문구로 수정했습니다.
      --%>
      <table:Table isEmpty="${empty ownerList}" emptyMessage="조회된 점주가 없습니다.">

        <jsp:attribute name="thead">
          <tr>
            <th class="text-center">No</th>
            <th class="text-center">아이디</th>
            <th class="text-center">점주명</th>
            <th class="text-center">등록일</th>
            <th class="text-center">상태</th>
          </tr>
        </jsp:attribute>

        <jsp:attribute name="tbody">
          <c:forEach var="u" items="${ownerList}">

            <%--
              점주 상세 페이지 URL입니다.

              기존 코드:
              <c:url var="detailUrl" value="$/admin/users/${u.userId}" />

              문제:
              value 앞에 $가 들어가 있어서 URL이 깨집니다.

              수정:
              /admin/users/${u.userId}
            --%>
            <c:url var="detailUrl" value="/admin/users/${u.userId}" />

            <%--
              기존 코드에 있던 formUrl은 현재 화면에서 사용하지 않으므로 제거했습니다.

              기존 코드:
              <c:url var="formUrl" value="/admin/users/${u.userId}" />
            --%>

            <%--
              기존 코드:
              <c:set var="u.Status" value="${empty inq.answerContent ? 'INACTIVE' : 'ACTIVE'}"></c:set>

              문제:
              1. u.Status는 User 객체의 실제 속성이 아닙니다.
              2. JSP EL은 대소문자를 구분하므로 Status가 아니라 status로 접근해야 합니다.
              3. inq라는 변수는 이 페이지에 존재하지 않습니다.
              4. 문의사항 답변 여부로 점주 상태를 판단하는 로직이므로 점주 목록에 맞지 않습니다.

              따라서 이 코드는 삭제하고 아래에서 ${u.status}를 직접 사용합니다.
            --%>

            <%--
              TableRow에 clickable과 href를 주면 행 클릭 이동을 위한 data 속성이 붙습니다.
              버튼 셀과 함께 쓰는 경우에는 행 클릭 정책이 업무 화면과 충돌하지 않는지 확인하세요.
            --%>
            <table:TableRow clickable="true" href="${detailUrl}">

              <%--
                목록 번호입니다.
                컨트롤러 또는 서비스에서 displayNo를 만들어 내려줘야 합니다.
              --%>
              <table:TextFitCell value="${u.displayNo}" />

              <%--
                점주 아이디입니다.
              --%>
              <table:TextCell value="${u.userId}" />

              <%--
                점주명입니다.
              --%>
              <table:TextCell value="${u.userName}" />

              <%--
                등록일입니다.

                기존 코드:
                ${fn:replace(user.createdAt, 'T', ' ')}

                문제:
                반복문 변수는 user가 아니라 u입니다.
                따라서 ${u.createdAt}으로 접근해야 합니다.
              --%>
              <table:DateTimeCell value="${u.createdAt}" />

              <%--
                점주 상태입니다.

                기존 코드:
                <display:InquiryStatusBadge value="${u.Status}"/>

                문제:
                1. ${u.Status}는 존재하지 않습니다.
                2. InquiryStatusBadge는 문의사항 답변 상태용 태그입니다.
                3. 점주 상태는 ACTIVE / INACTIVE 기준으로 직접 배지를 표시하는 것이 안전합니다.
              --%>
              <table:FitCell align="center">

              	<c:choose>

              	  <%--
              	    영업중 상태입니다.
              	  --%>
              	  <c:when test="${u.status eq 'ACTIVE'}">
              	    <span class="badge badge-success">영업중</span>
              	  </c:when>

              	  <%--
              	    폐점 상태입니다.
              	  --%>
              	  <c:when test="${u.status eq 'INACTIVE'}">
              	    <span class="badge badge-secondary">폐점</span>
              	  </c:when>

              	  <%--
              	    그 외 상태값이 들어온 경우입니다.
              	    status가 비어 있으면 - 로 표시합니다.
              	  --%>
              	  <c:otherwise>
              	    <span class="badge badge-light">
              	      ${empty u.status ? '-' : u.status}
              	    </span>
              	  </c:otherwise>

              	</c:choose>

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