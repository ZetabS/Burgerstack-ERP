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
    text-align:right;
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
	
	#changePwdBtn{
    width:150px;
    height:45px;
    border:none;
    border-radius:8px;
    background:#ff7f27;
    color:white;
    font-size:15px;
    cursor:pointer;
	}
	
	#changePwdBtn:hover{
	    background:#e86d0c;
	}
	
	#updateBtn:hover{
	    background:#212529;
	}
	.home-btn-area{
    text-align: center;
    margin-top: 30px;
	}
	
	#homeBtn{
	    width: 150px;
	    height: 45px;
	    border: none;
	    border-radius: 8px;
	    cursor: pointer;
	    font-size: 16px;
	}
</style>
</head>
<body>

<t:menubarHO>

	<div class="mypage-container">
	
	<h1>관리자 마이페이지</h1>

	<form id="update" action="/burgerstack/admin/update" method="post">
		
		    <table>
		        <tr>
		            <th>아이디</th>
		            <td id="userId"></td>
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
		
		    <div class="button-area">
			    <button id="updateBtn">
			        정보 수정
			    </button>
			</div>
		    
		    <hr>
		    
	</form>
		    
	<form id="update-password" action="/burgerstack/admin/updatePassword" method="post">
		    
			<h2>비밀번호 변경</h2>
			
			<table>
			    <tr>
			        <th>현재 비밀번호</th>
			        <td>
			            <input type="password" id="currentPwd">
			        </td>
			    </tr>
			
			    <tr>
			        <th>새 비밀번호</th>
			        <td>
			            <input type="password" id="newPwd">
			        </td>
			    </tr>
			
			    <tr>
			        <th>비밀번호 확인</th>
			        <td>
			            <input type="password" id="checkPwd">
			        </td>
			    </tr>
			</table>
			
			<div class="button-area">
			    <button id="changePwdBtn">
			        비밀번호 변경
			    </button>
			</div>
		
		</div>
		
	</form>

		<form id="home-button" action="/burgerstack/admin/homebutton" method="get">
			<div class="home-btn-area">
	    		<button type="submit" id="homeBtn">
			        홈으로
			    </button>
			</div>
		</form>

</t:menubarHO>


</body>
</html>