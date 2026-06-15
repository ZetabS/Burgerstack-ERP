<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<title>문의사항 수정</title>

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

#deleteBtn {
	margin-right: 10px;
	background: #FF5B5B;
	color: white;
}
</style>

<%--
	c:url은 context-path(/burgerstack)를 자동으로 붙여줍니다.
	따라서 value에는 /burgerstack을 직접 쓰지 않습니다.
--%>
<c:url var="updateUrl" value="/owner/inquiries/${inquiryId}" />
<c:url var="deleteUrl" value="/owner/inquiries/${inquiryId}/delete" />
<c:url var="listUrl" value="/owner/inquiries" />

<t:layout>

	<div class="main-content">
		<div class="form-container">
			<h1>문의사항 수정</h1>

			<%--
				문의사항 수정 form입니다.
				최종 요청 URL 예시:
				/burgerstack/owner/inquiries/11
			--%>
			<form action="${updateUrl}" method="post">

				<div class="form-group">
					<input type="text"
						   name="title"
						   class="input-title"
						   value="<c:out value='${inquiry.title}' />"
						   required>
				</div>

				<div class="form-group">
					<textarea name="content"
							  class="textarea-content"
							  required><c:out value="${inquiry.content}" /></textarea>
				</div>

				<div class="btn-area">

					<%-- 수정 저장 버튼 --%>
					<button type="submit" id="saveBtn">등록 및 수정</button>

					<%--
						삭제 버튼입니다.
						formaction을 사용해서 같은 form에서 삭제 URL로 전송합니다.
						최종 요청 URL 예시:
						/burgerstack/owner/inquiries/11/delete
					--%>
					<button type="submit"
					        id="deleteBtn"
					        formaction="${deleteUrl}"
					        formnovalidate>
					    삭제
					</button>

					<%--
						목록으로 이동 버튼입니다.
						최종 이동 URL 예시:
						/burgerstack/owner/inquiries
					--%>
					<button type="button"
							id="homeBtn"
							onclick="location.href='${listUrl}'">
						목록으로
					</button>

				</div>
			</form>
		</div>
	</div>

</t:layout>