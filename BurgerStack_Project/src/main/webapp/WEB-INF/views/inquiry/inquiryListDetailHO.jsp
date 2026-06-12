<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.form-container {
	width: 100%;
	max-width: 900px;
	background: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
#title {
	padding-top: 30px;
	font-weight: 1000;
	text-align: center;
	margin-bottom: 30px;
}

.inquiry-title-box {
	border: 1px solid #ccc;
	border-radius: 3px;
	padding: 12px;
	font-size: 15px;
	margin-bottom: 10px;
}

.inquiry-info {
	text-align: right;
	font-size: 13px;
	margin-bottom: 10px;
	font-weight: bold;
}

.inquiry-content {
	border: 1px solid #bdbdbd;
	min-height: 250px;
	padding: 20px;
	margin-bottom: 30px;
	white-space: pre-line;
	line-height: 1.6;
}

.answer-info {
	text-align: right;
	font-size: 13px;
	margin-bottom: 10px;
	font-weight: bold;
}

.answer-content {
	border: 1px solid #bdbdbd;
	min-height: 180px;
	padding: 20px;
	margin-bottom: 30px;
	white-space: pre-line;
	line-height: 1.6;
}

.btn-area {
	text-align: center;
	margin-top: 20px;
}

.btn {
	width: 120px;
	height: 45px;
	border: none;
	border-radius: 8px;
	font-size: 15px;
	font-weight: bold;
	cursor: pointer;
}

.reply-btn {
	background: #222831;
	color: white;
}

.list-btn {
	background: #6c757d;
	color: white;
	margin-left: 10px;
}

.btn-area {
	text-align: center;
	margin-top: 30px;
}

.btn-area button {
	width: 150px;
	height: 45px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-size: 16px;
}

#saveBtn {
	margin-right: 10px;
	background: #007bff;
	color: white;
}

#homeBtn {
	margin-left: 0;
	background: #6c757d;
	color: white;
}
</style>
</head>
<body>
	<t:layout>
		<div class="form-container">

		<h1 id="title">문의사항 상세 보기</h1>

		<div class="inquiry-title-box">${inquiry.title}</div>

		<div class="inquiry-info" name="createAt">문의 등록일 :
			${fn:replace(inquiry.createdAt, 'T', ' ')}</div>

		<div class="inquiry-content">${inquiry.content}</div>


		<div class="answer-info" name="answeredAt">답변 등록일 :
			${fn:replace(inquiry.answeredAt, 'T', ' ')}</div>

		<div class="answer-content">

			<c:choose>
				<c:when test="${empty inquiry.answerContent}">
			            아직 등록된 답변이 없습니다.
			        </c:when>

				<c:otherwise>
			            ${inquiry.answerContent}
			        </c:otherwise>

			</c:choose>

		</div>

		<div class="btn-area">

			<button type="button" id="saveBtn"
				onclick="location.href='/burgerstack/admin/inquiries/${inquiryId}/edit'">
				답변 등록 및 수정</button>

			<button type="button" id="homeBtn"
				onclick="location.href='burgerstack/admin/inquiries'">목록</button>

		</div>
		<hr>

		<div class="file-area">
			<label>첨부파일</label> <input type="file" name="uploadFile">
		</div>
		</div>
	</t:layout>

</body>
</html>