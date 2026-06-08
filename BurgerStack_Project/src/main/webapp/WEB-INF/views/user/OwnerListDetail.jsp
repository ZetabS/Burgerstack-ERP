<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
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
</head>
<body>

	<t:menubarHO>
		<h1 id="title" align="center">점주 계정 상세조회</h1>

		<form id="OwnerListDetail"
			action="/burgerstack/admin/users/${user.userId}" method="get">
			<table>
				<tr>
					<th>아이디</th>
					<td>${user.userId}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${user.userName}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${user.phone}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${user.email}</td>
				</tr>
				<tr>
					<th>등록일</th>
					<td>${user.createdAt}</td>
				</tr>
				<tr>
					<th>상태</th>
					<td colspan="2"><label> &nbsp;&nbsp;사용중 <input
							type="radio" name="status" value="ACTIVE" checked>
					</label> &nbsp;&nbsp;&nbsp; <label> &nbsp;&nbsp;정지 <input
							type="radio" name="status" value="INACTIVE">
					</label></td>
				</tr>
			</table>
				<div class="btn-area">
				
				    <button type="button"
				            id="saveBtn"
				            onclick="location.href='/burgerstack/admin/users/${user.userId}/status'">
				        저장
				    </button>
				
				    <button type="button"
				            id="homeBtn"
				            onclick="location.href='/burgerstack/admin/users'">
				        이전으로
				    </button>
				
				</div>
		</form>
	</t:menubarHO>

</body>
</html>