<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BurgerStack</title>
<link rel="shortcut icon" type="image/x-icon" href="/resources/images/BS_logo2.png" />
<style>
	body{
    background-color:#f5f6fa;
    margin:0;
    padding:0;
    font-family:'맑은 고딕', sans-serif;
	}
	
	.mypage-container{
	    width:700px;
	    margin:50px auto;
	    background:white;
	    padding:40px;
	    border-radius:12px;
	    box-shadow:0 2px 10px rgba(0,0,0,0.1);
	}
	
	.mypage-container h2{
	    text-align:center;
	    margin-bottom:30px;
	    color:#333;
	}
	
	table{
	    width:100%;
	    border-collapse:collapse;
	}
	
	th{
	    width:150px;
	    background:#f8f9fa;
	    text-align:center;
	    padding:15px;
	    border-bottom:1px solid #ddd;
	}
	
	td{
	    padding:15px;
	    border-bottom:1px solid #ddd;
	}
	
	input{
	    width:95%;
	    padding:10px;
	    border:1px solid #ccc;
	    border-radius:5px;
	    font-size:14px;
	}
	
	input:focus{
	    outline:none;
	    border-color:#6c757d;
	}
	
	.button-area{
	    text-align:center;
	    margin-top:30px;
	}
	
	#updateBtn{
	    width:150px;
	    height:45px;
	    border:none;
	    border-radius:8px;
	    background:#343a40;
	    color:white;
	    font-size:15px;
	    cursor:pointer;
	    transition:0.2s;
	}
		#updateBtn_1{
	    width:150px;
	    height:45px;
	    border:none;
	    border-radius:8px;
	    background:#FF7F50;
	    color:white;
	    font-size:15px;
	    cursor:pointer;
	    transition:0.2s;
	 }
	
	#updateBtn:hover{
	    background:#212529;
	}
</style>
</head>
<body>

<t:menubarBO>
	 
		<div class="mypage-container">
		
		    <h2>점포 관리자 정보</h2>
		
		    <table>
		        <tr>
		            <th>아이디</th>
		            <td id="loginId"></td>
		        </tr>
		
		        <tr>
		            <th>이름</th>
		            <td id="userName"></td>
		        </tr>
		
		        <tr>
		            <th>전화번호</th>
		            <td>
		                <input type="text" id="phone">
		            </td>
		        </tr>
		
		        <tr>
		            <th>이메일</th>
		            <td>
		                <input type="text" id="email">
		            </td>
		        </tr>
		    </table>
		
		    <br>
		
		    <button id="updateBtn">
		        정보 수정
		    </button>
		    
		    <button id="updateBtn_1">
		        비밀번호 번경
		    </button>
		
		</div>
	
	
	
	<!-- 
			<div class="mypage-container">
		
		    <h2 class="mypage-title">점포 관리자 정보</h2>
		
		    <table class="info-table">
		        <tr>
		            <th>아이디</th>
		            <td>${loginUser.loginId}</td>
		        </tr>
		
		        <tr>
		            <th>이름</th>
		            <td>${loginUser.userName}</td>
		        </tr>
		
		        <tr>
		            <th>전화번호</th>
		            <td>${loginUser.phone}</td>
		        </tr>
		
		        <tr>
		            <th>이메일</th>
		            <td>${loginUser.email}</td>
		        </tr>
		    </table>
		
		    <div class="btn-area">
		        <button class="btn"
		                onclick="location.href='/burgerstack/user/updateForm'">
		            정보 수정
		        </button>
		
		        <button class="btn"
		                onclick="location.href='/burgerstack/user/changePwdForm'">
		            비밀번호 변경
		        </button>
		    </div>
		
		</div>
		 -->
</t:menubarBO>


</body>
</html>