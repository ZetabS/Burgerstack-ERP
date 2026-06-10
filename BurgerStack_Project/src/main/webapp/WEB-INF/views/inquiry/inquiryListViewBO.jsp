<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항 목록 조회</title>

<style>
table {
	width: 100%;
	border-collapse: collapse;
	table-layout: fixed;
}

th {
	background-color: #22c55e;
	color: white;
	height: 40px;
	text-align: center !important;
	vertical-align: middle !important;
}

td {
	text-align: center !important;
	vertical-align: middle !important;
	height: 40px;
	border-bottom: 1px solid #ddd;
}

.search-area {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 15px;
	gap: 10px;
}

.btn {
	background-color: #333;
	color: white;
	border: none;
	padding: 5px 15px;
	cursor: pointer;
	border-radius: 4px;
}

.btn:hover {
	background-color: #555;
}

.title-link {
	text-decoration: none;
	color: black;
	font-weight: bold;
}

.title-link:hover {
	color: #22c55e;
	text-decoration: underline;
}
</style>
</head>
<body>

	<t:menubarBO>

		<h1>나의 문의사항</h1>

		<div class="content">

			<form action="/burgerstack/owner/inquiries"
				method="get">
				<div class="search-area">
					<select name="condition" style="padding: 5px;">
						<option value="title" ${condition == 'title' ? 'selected' : ''}>제목</option>
						<option value="content"
							${condition == 'content' ? 'selected' : ''}>내용</option>
						<option value="inquiryId"
							${condition == 'inquiryId' ? 'selected' : ''}>글번호</option>
					</select> <input type="text" name="keyword" value="${keyword}"
						placeholder="검색어 입력" style="padding: 5px;">
					<button type="submit" class="btn">검색</button>
				</div>
			</form>

			<table>
				<colgroup>
					<col style="width: 10%">
					<col style="width: 50%">
					<col style="width: 20%">
					<col style="width: 20%">
				</colgroup>

				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>답변상태</th>
					</tr>
				</thead>

				<tbody>
					<c:choose>
						<c:when test="${empty inquiryList}">
							<tr>
								<td colspan="4">조회된 문의사항이 없습니다.</td>
							</tr>
						</c:when>

						<c:otherwise>
							<c:forEach var="inq" items="${inquiryList}">
								<tr>
									<td>${inq.inquiryId}</td>

									<td style="text-align: left !important; padding-left: 20px;">
										<a class="title-link"
										href="${pageContext.request.contextPath}/owner/inquiries/${inq.inquiryId}">
											${inq.title} </a>
									</td>

									<td>${inq.createdAt}</td>

									<td><c:choose>
											<c:when test="${not empty inq.answerContent}">
												<span style="color: #22c55e; font-weight: bold;">답변완료</span>
											</c:when>
											<c:otherwise>
												<span style="color: #ff4d4f; font-weight: bold;">미답변</span>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			<div class="pagination" style="text-align: center; margin-top: 20px;">
			    <c:forEach var="p" begin="${startPage}" end="${endPage}">
			        <c:choose>
			            <c:when test="${p == currentPage}">
			                <strong style="color: green;">${p}</strong>
			            </c:when>
			            <c:otherwise>
			                <a href="?page=${p}&condition=${condition}&keyword=${keyword}">${p}</a>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			</div>

	</t:menubarBO>

</body>
</html>