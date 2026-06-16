<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<c:url var="baseUrl" value="/admin/stores" />
<c:url var="newUrl" value="/admin/stores/new" />

<t:layout>
  <layout:ListPage title="점포 목록" description="등록된 점포 정보를 조회하고 상세 정보를 확인할 수 있습니다.">

    <jsp:attribute name="actions">
      <a href="${baseUrl}" class="btn btn-secondary">초기화</a>
      <a href="${newUrl}" class="btn btn-primary ml-2">점포 등록</a>
    </jsp:attribute>

    <jsp:attribute name="toolbar">
      <form action="${baseUrl}" method="get">
        <input type="hidden" name="page" value="1" />

        <layout:Toolbar>
          <jsp:attribute name="left">

            <select name="status"
                    class="form-control mr-2"
                    onchange="this.form.submit()">
              <option value="" ${empty status ? 'selected' : ''}>
                전체 상태
              </option>

              <option value="OPEN" ${status eq 'OPEN' ? 'selected' : ''}>
                영업중
              </option>

              <option value="CLOSED" ${status eq 'CLOSED' ? 'selected' : ''}>
                폐점
              </option>
            </select>

            <select name="sort"
                    class="form-control mr-2"
                    onchange="this.form.submit()">
              <option value="" ${empty sort ? 'selected' : ''}>
                최신순
              </option>

              <option value="code" ${sort eq 'code' ? 'selected' : ''}>
                점포코드순
              </option>

              <option value="name" ${sort eq 'name' ? 'selected' : ''}>
                점포명순
              </option>

              <option value="status" ${sort eq 'status' ? 'selected' : ''}>
                상태순
              </option>
            </select>

          </jsp:attribute>

          <jsp:attribute name="right">
            <common:SearchBar
              name="keyword"
              value="${keyword}"
              placeholder="점포명, 코드, 주소 검색" />
          </jsp:attribute>
        </layout:Toolbar>
      </form>
    </jsp:attribute>

    <jsp:attribute name="table">
      <table:Table isEmpty="${empty list}" emptyMessage="조회된 점포가 없습니다.">

        <jsp:attribute name="thead">
          <tr>
            <th>점포 코드</th>
            <th>점포명</th>
            <th>주소</th>
            <th class="text-center">상태</th>
          </tr>
        </jsp:attribute>

        <jsp:attribute name="tbody">
          <c:forEach var="s" items="${list}">
            <c:url var="detailUrl" value="/admin/stores/${s.storeId}" />

            <c:set var="storeCodeText" value="${s.storeCode}" />
            <c:if test="${empty storeCodeText}">
              <c:set var="storeCodeText" value="S${s.storeId}" />
            </c:if>

            <table:TableRow clickable="true" href="${detailUrl}">
              <table:TextFitCell value="${storeCodeText}" />
              <table:TextCell value="${s.storeName}" />
              <table:TextCell value="${empty s.address ? '-' : s.address}" />

              <table:FitCell>
                <c:choose>
                  <c:when test="${s.status eq 'OPEN'}">
                    <span class="badge badge-success">영업중</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge badge-danger">폐점</span>
                  </c:otherwise>
                </c:choose>
              </table:FitCell>
            </table:TableRow>
          </c:forEach>
        </jsp:attribute>

      </table:Table>
    </jsp:attribute>

    <jsp:attribute name="pagination">
      <t:pagination pageInfo="${pageInfo}" />
    </jsp:attribute>

  </layout:ListPage>
</t:layout>