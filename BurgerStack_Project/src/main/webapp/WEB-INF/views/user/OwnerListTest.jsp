<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>

<title>Insert title here</title>
<style>
.form-container {
	width: 100%;
	max-width: 2000px;
	background: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
#title {
	padding-top: 30px;
	font-weight: 1000;
}
table {
	width: 100%;
	border-collapse: collapse;
}

th {
	width: 150px;
	background: #f8f9fa;
	text-align: center;
	padding: 15px;
	border-bottom: 1px solid #ddd;
}

td {
	padding: 15px;
	border-bottom: 1px solid #ddd;
}

input {
	width: 95%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
}
.actionBtn {
	width: 150px;
	height: 45px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-size: 16px;
	margin: 0 5px;
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


	<t:layout>
	
		<h1 id="title" align="center">점주 계정 수정 페이지</h1>

		<form action="/burgerstack/admin/users/${user.userId}" method="post" class="form-container">
			<table>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="userId" value="${user.userId}">
					</td>
				</tr>
				<tr>
				    <th>비밀번호</th>
				    <td>
				        <input type="text"
				               id="password"
				               name="password"
				               readonly>
				
				        <button type="button"
				                onclick="resetPassword()">
				            초기화
				        </button>
				    </td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="userName"
						value="${user.userName}"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="phone" value="${user.phone}">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name="email" value="${user.email}">
					</td>
				</tr>
				<tr>
					<th>상태</th>
					<td>
						<div class="status-box">
							<label> <input type="radio" name="status" value="ACTIVE"
								${user.status eq 'ACTIVE' ? 'checked' : ''} checked> 사용중
							</label> <label> <input type="radio" name="status"
								value="INACTIVE" ${user.status eq 'INACTIVE' ? 'checked' : ''}>
								정지
							</label>
						</div>
					</td>
				</tr>
			</table>
			<div class="btn-area">
				<button type="submit" id="saveBtn">저장</button>
				<button type="button" id="cancelBtn"
					onclick="location.href='/burgerstack/admin/users/${user.userId}'">
					취소</button>
			</div>
		</form>

			<script>
				function resetPassword(){
				
				    const chars =
				        "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
				        "abcdefghijklmnopqrstuvwxyz" +
				        "0123456789";
				
				    let pwd = "";
				
				    for(let i=0; i<10; i++){
				        pwd += chars.charAt(
				            Math.floor(Math.random() * chars.length)
				        );
				    }
				
				    document.getElementById("password").value = pwd;
				}
			</script>
				
		
	</t:layout>
