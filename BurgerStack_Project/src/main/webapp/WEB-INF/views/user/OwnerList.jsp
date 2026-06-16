<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%--
  c:url은 context-path(/burgerstack)를 자동으로 붙여줍니다.
  따라서 value에는 /burgerstack을 직접 쓰지 않습니다.

  최종 URL:
  /burgerstack/admin/users
--%>
<c:url var="baseUrl" value="/admin/users" />

<t:layout>
  <layout:ListPage title="점주 목록 페이지" description="등록된 점주 계정을 조회할 수 있습니다.">

    <jsp:attribute name="actions">
      <a href="${baseUrl}" class="btn btn-secondary">초기화</a>
    </jsp:attribute>

    <jsp:attribute name="toolbar">
      <form action="${baseUrl}" method="get">
        <input type="hidden" name="page" value="1" />
        <%-- size 파라미터도 컨트롤러와 맞추기 위해 10으로 고정하거나 pageInfo에서 꺼냅니다 --%>
        <input type="hidden" name="size" value="${empty pageInfo.size ? 10 : pageInfo.size}" />

        <layout:Toolbar>
          <jsp:attribute name="left">
            <%-- 💡 수정 1: condition -> status 로 이름 변경 --%>
            <select name="status" class="form-control mr-2">
                <option value="" ${empty param.status ? 'selected' : ''}>
                    전체상태
                </option>
                <option value="ACTIVE" ${param.status eq 'ACTIVE' ? 'selected' : ''}>
                    영업중
                </option>
                <option value="INACTIVE" ${param.status eq 'INACTIVE' ? 'selected' : ''}>
                    폐점
                </option>
            </select>
          </jsp:attribute>

          <jsp:attribute name="right">          
            <common:SearchBar name="keyword" value="${keyword}" placeholder="아이디, 점주명 검색" />
          </jsp:attribute>
        </layout:Toolbar>
      </form>
    </jsp:attribute>

    <jsp:attribute name="table">
      <table:Table isEmpty="${empty ownerList}" emptyMessage="조회된 점주 계정이 없습니다.">
        <jsp:attribute name="thead">
          <tr>
            <th class="text-center">No</th>
            <th class="text-right">점주 아이디</th>
            <th class="text-right">점포명(이름)</th>
            <th class="text-right">등록일</th>
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
            
            <%-- 💡 수정 2: 에러를 유발하는 잘못된 <c:set var="u.status"...> 삭제 --%>
            
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
              <table:TextCell value="${u.userName}" /> <%-- 주의: 현재 점포명 대신 점주 이름이 출력되고 있습니다 --%>
              <table:DateTimeCell value="${u.createdAt}" />
              <table:FitCell align="left">
                <%-- DB에서 꺼내온 u.status ('ACTIVE'/'INACTIVE')가 그대로 들어갑니다. --%>
                <display:InquiryStatusBadge value="${u.status}"/>
              </table:FitCell>

            </table:TableRow>
          </c:forEach>
        </jsp:attribute>
      </table:Table>
    </jsp:attribute>

    <jsp:attribute name="pagination">
      <%-- 💡 수정 3: 컨트롤러 모델 이름에 맞게 view.pageInfo -> pageInfo 로 변경 --%>
      <t:pagination pageInfo="${pageInfo}" />
    </jsp:attribute>

  </layout:ListPage>
</t:layout>