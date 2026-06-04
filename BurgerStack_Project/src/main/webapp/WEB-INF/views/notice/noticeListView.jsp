<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BurgerStack</title>
<style>

table {
  border-collapse: collapse;
  width: max-content; 
}

table thead tr {
  display: grid;
  grid-template-columns: 50px 500px 150px;
  align-items: center;
  border-bottom: 2px solid #ddd;
  font-weight: bold;
  background-color: #22C55E;
  color: white;
  padding: 10px 0;
}

table tbody tr {
  display: grid;
  grid-template-columns: 50px 500px 150px;
  align-items: center;
  border-bottom: 1px solid #eee;
  padding: 8px 0;
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

/* 💡 화면 중앙에 배치하되, 내부 요소들은 왼쪽 정렬이 되도록 감싸는 컨테이너 추가 */
.content-container {
    width: max-content;
    margin: 0 auto;       /* 이 부분이 흰색 판 안에서 전체 요소를 가운데로 정렬해 줍니다 */
    text-align: left;     /* 내부 텍스트(h2)와 테이블은 왼쪽 정렬 */
}

.content-container h2 {
    margin-bottom: 20px; /* 타이틀과 테이블 사이의 간격 조정 */
}
</style>
</head>
<body>
    <t:menubarHO>

        
        <div class="content-container">
            <h2>공지사항 목록 조회</h2>
            <br>
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
                        <tr>
                            <td>${n.noticeId}</td>
                            <td>${n.title}</td>
                            <td>${n.createdAt}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <br>
        <t:pagination pageInfo="${pageInfo}"/>
    </t:menubarHO>
    <script>

    </script>
</body>
</html>