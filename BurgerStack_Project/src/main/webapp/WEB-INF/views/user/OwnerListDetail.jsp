<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.form-container {
	width: auto%;
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
.status-badge{
    display:inline-block;
    padding:6px 14px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
    color:white;
}

.status-active{
    background-color:#28a745;
}

.status-inactive{
    background-color:#dc3545;
}
</style>
</head>
<body>

	<t:layout>
		<h1 id="title" align="center">점주 계정 상세조회</h1>

		<form id="OwnerListDetail"
			action="/burgerstack/admin/users/${user.userId}" method="get" class="form-container">
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
					<td>${fn:replace(user.createdAt, 'T', ' ')}</td>
				</tr>
				<tr>
				    <th>상태</th>
				    <td>
				        <c:choose>
				            <c:when test="${user.status eq 'ACTIVE'}">
				                <span class="status-badge status-active">
				                    영업중
				                </span>
				            </c:when>
				            <c:otherwise>
				                <span class="status-badge status-inactive">
				                    폐점
				                </span>
				            </c:otherwise>
				        </c:choose>
				    </td>
				</tr>
				
			</table>
				<div class="btn-area">
				
				    <button type="button"
				            id="saveBtn"
				            onclick="location.href='/burgerstack/admin/users/${user.userId}/edit'">
				        수정
				    </button>
				
				    <button type="button"
				            id="homeBtn"
				            onclick="location.href='/burgerstack/admin/users'">
				        목록
				    </button>
				
				</div>
		</form>
	</t:layout>

</body>
</html>