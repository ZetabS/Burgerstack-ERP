<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<style>

table {
  border-collapse: collapse;
  width: max-content;
}

table thead tr {
  display: grid;
  grid-template-columns: 50px 500px 200px;
  align-items: center;
  border-bottom: 2px solid #FFFFFF;
  font-weight: bold;
  background-color: #22C55E;
  color: white;
  padding: 10px 0;
}

table tbody tr {
  display: grid;
  grid-template-columns: 50px 500px 200px;
  align-items: center;
  border-bottom: 1px solid #eee;
  padding: 10px 0;
}

table tbody tr:hover {
  cursor: pointer;
  background-color: #f4fbf7;
}
table tbody tr td:nth-child(1) {
    text-align: center;
}

table tbody tr td:nth-child(2) {
    text-align: left;
    padding-left: 15px;
    padding-right: 15px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

table tbody tr td:nth-child(3) {
    text-align: center;
}

.content-container {
    width: max-content;
    margin: 0 auto;
    text-align: left;
}

.content-container h2 {
    margin-bottom: 20px;
}
</style>
    <t:layout>

        <div class="outer">
            <div class="content-container">
                <br>
                <h2 style="padding-left : 20px;">
                    <b>공지사항 목록 조회</b>
                </h2>
                <table>
                    <thead align="center">
                        <tr>
                            <th>No</th>
                            <th>제목</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty notices}">
                            <tr style="display: flex; justify-content: center; padding: 30px 0; color: #888;">
                                <td colspan="3">등록된 공지사항이 없습니다.</td>
                            </tr>
                        </c:if>

                        <c:forEach items="${notices}" var="n">
                            <tr onclick="location.href='${pageContext.request.contextPath}/owner/notices/${n.noticeId}'">
                                <td><c:out value="${n.noticeId}" /></td>
                                <td><c:out value="${n.title}" /></td>
                                <td><c:out value="${n.listDate}" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <br><br>
            <t:pagination pageInfo="${pageInfo}"/>
            <br><br>
        </div>
    </t:layout>