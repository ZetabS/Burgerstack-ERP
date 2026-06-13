<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>

<title>문의사항 목록 조회</title>

<style>
.form-container {
	width: 100%;
	max-width: 2000px;
	background: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

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

tbody tr:hover {
	background-color: #f5f5f5;
	cursor: pointer;
}
.status-badge {
	display: inline-block;
	padding: 6px 14px;
	border-radius: 20px;
	font-size: 13px;
	font-weight: bold;
	color: white;
}

.status-active {
	background-color: #28a745;
}

.status-inactive {
	background-color: #dc3545;
}
</style>


	<t:layout>


		<h1>문의사항 목록 조회</h1>

		<div class="content">

			<form action="/burgerstack/admin/inquiries" method="get">
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
			<table class="form-container">
				<colgroup>
					<col style="width: 10%">
					<col style="width: 40%">
					<col style="width: 15%">
					<col style="width: 20%">
					<col style="width: 15%">
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>제목</th>
						<th>점포명</th>
						<th>답변상태</th>
						<th>등록일</th>
					</tr>
				</thead>

				<tbody>

					<c:choose>

						<c:when test="${empty inquiryList}">
							<tr>
								<td colspan="7">조회된 문의사항이 없습니다.</td>
							</tr>
						</c:when>

						<c:otherwise>

							<c:forEach var="inq" items="${inquiryList}">

								<tr
									onclick="location.href='${pageContext.request.contextPath}/admin/inquiries/${inq.inquiryId}'"
									style="cursor: pointer;">

									<td>${inq.inquiryId}</td>

									<td style="text-align: left !important; padding-left: 20px;">
										${inq.title}</td>

									<td>${inq.storeName}</td>

									<td><c:choose>
											<c:when test="${not empty inq.answerContent}">
												<span class="status-badge status-active"> 답변완료 </span>
											</c:when>
											<c:otherwise>
												<span class="status-badge status-inactive"> 미답변 </span>
											</c:otherwise>
										</c:choose></td>

									<td>${inq.createdAt}</td>
								</tr>

							</c:forEach>

						</c:otherwise>

					</c:choose>

				</tbody>

			</table>

		</div>

		<div class="pagination"
			style="display: flex; justify-content: center; align-items: center; margin-top: 20px; gap: 10px;">
			<c:forEach var="p" begin="${startPage}" end="${endPage}">
				<c:choose>
					<c:when test="${p == currentPage}">
						<strong style="color: green; font-size: 1.2em;">${p}</strong>
					</c:when>
					<c:otherwise>
						<a href="?page=${p}&condition=${condition}&keyword=${keyword}">${p}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>


	</t:layout>
