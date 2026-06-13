<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
    padding: 0;
    margin: 0;
    display: flex;
    justify-content: center;
}

.form-container {
    width: 100%;
    max-width: 2000px;
    background: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);

    margin-top: 0;
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
#deleteBtn {
	margin-right: 10px;
	background: #FF5B5B;
	color: white;
}
.layout__main .main-content{
    padding-top:0 !important;
    margin-top:0 !important;
}

.layout__main .form-container{
    margin-top:0 !important;
}
</style>


	<t:layout>

		<div class="main-content">
			<div class="form-container">
				<h1>문의사항 수정</h1>

				<form
					action="/burgerstack/admin/inquiries/${inquiryId}"
					method="post" enctype="multipart/form-data">
					<div class="form-group">
					    <strong>제목</strong><br>
					    ${inquiry.title}
					</div>
					
					<div class="form-group">
					    <strong>문의내용</strong><br>
					    ${inquiry.content}
					</div>
					
					<div class="form-group">
					    <textarea name="answerContent"
					              class="textarea-content"
					              required>${inquiry.answerContent}</textarea>
					</div>
					
					<div class="btn-area">
						<button type="submit" id="saveBtn">등록 및 수정</button>
	
					<button type="submit" id="deleteBtn"
					        formaction="/burgerstack/admin/inquiries/${inquiryId}/delete">
					    삭제
					</button>
	
						<button type="button" id="homeBtn"
							onclick="location.href='/burgerstack/admin/inquiries'">
							목록으로</button>
					</div>
					<div class="file-area">
					    <label>첨부파일</label>
					    <input type="file" name="uploadFile">
					</div>
				</form>
			</div>
		</div>
	</t:layout>
