<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 화면 레이아웃 및 스타일 간이 정의 */
body {
	margin: 0;
	font-family: 'Malgun Gothic', sans-serif;
	background-color: #f4f5f7;
}

.container {
	display: flex;
	min-height: 100vh;
}

/* 메인 콘텐츠 영역 */
.main-content {
	flex: 1;
	padding: 40px;
	display: flex;
	justify-content: center;
}

.form-container {
	width: 100%;
	max-width: 900px;
	background: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	font-size: 28px;
	color: #333;
	margin-bottom: 30px;
}

/* 폼 요소 스타일 */
.form-group {
	margin-bottom: 20px;
	position: relative;
}

.input-title {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	font-size: 16px;
}

.date-info {
	text-align: right;
	font-size: 14px;
	color: #666;
	margin: 10px 0;
}

.textarea-content {
	width: 100%;
	height: 300px;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	font-size: 15px;
	resize: none;
}

/* 답변 영역 (비활성화 상태) */
.reply-section {
	background-color: #fafafa;
	border: 1px solid #e0e0e0;
	padding: 20px;
	border-radius: 4px;
	color: #666;
	margin-top: 20px;
}

.btn-area{
    text-align:center;
    margin-top:30px;
}

.btn-area button{
    width:150px;
    height:45px;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-size:16px;
}

#saveBtn{
    margin-right:10px;
	background: #007bff;
	color: white;    
}

#homeBtn{
    margin-left:0;
	background: #6c757d;
	color: white;    
}
</style>

</head>
<body>
	<t:layout>

		<div class="main-content">
			<div class="form-container">
				<h1>문의사항 작성</h1>

				<form
					action="/burgerstack/owner/inquiries/new"
					method="post">
					<div class="form-group">
						<input type="text" name="title" class="input-title"
							placeholder="제목을 입력해주세요." required>
					</div>

					<div class="date-info">
						<strong>문의 등록일 :</strong>
						<jsp:useBean id="now" class="java.util.Date" />
						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
					</div>

					<div class="form-group">
						<textarea name="content" class="textarea-content"
							placeholder="문의하실 내용을 상세히 적어주세요." required></textarea>
					</div>

					<div class="date-info">
						<strong>답변 등록일 :</strong>
					</div>
					<div class="reply-section">아직 등록된 답변이 없습니다.</div>
					
					
					<div class="btn-area">
						<button type="submit" id="saveBtn">답변 등록</button>
	
						<button type="button" id="homeBtn"
							onclick="location.href='/burgerstack/admin/dashboard'">
							이전으로</button>
					</div>
					
				</form>
			</div>
		</div>
	</t:layout>
</body>
</html>