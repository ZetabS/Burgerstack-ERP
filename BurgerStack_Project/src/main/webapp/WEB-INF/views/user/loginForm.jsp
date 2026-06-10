<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
	<style>
	#header{
    	text-align:center;
    	padding-top : 30px;
	}

	#header img{
		width:120px;
	}
	#login-form table{
    	margin:auto;
	}
	.outer {
		width : 500px;
		border : 1px solid lightgray;
		border-radius: 15px;
		margin : auto;
		margin-top : 50px;
		padding-bottom:40px;
	}
	#sign{
		margin-top:20px;
		margin-bottom:40px;
		color: coral;
	}
	
	#login-form input[type=text],
	#login-form input[type=password]{
		width:220px;
		height:32px;
		border:1px solid lightgray;
	}

	#loginbutton{
	    display:block;
	    width:300px;
	    height:50px;
	
	    margin:20px auto;
	
	    border-radius:10px;
	    border:1px solid lightgray;
	
	    background-color:coral;
	    color:white;
	
	    font-size:18px;
	    font-weight:bold;
	}
	label{
		font-size:12px;
	}
	#found{
		padding-left: 70px;
		padding-bottom: 5px;

	}
	.footer{
		width: 250px;
		margin: auto;
		text-align: left;
		padding-top: 20px;
		padding-bottom: 15px;
	}
	#loginMessage{
	    text-align:center;
	    color:red;
	    font-size:14px;
	    margin-top:10px;
	}
	</style>

<!-- JSP 에서 부트스트랩 연동도 가능함!! -->
<!-- 부트스트랩 CDN 방식으로 연동하는 구문들 -->
<!-- 예쁘게 정의된 스타일들이 들어 있는 CSS 파일 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- 간단한 동작들을 정의해둔 JS 파일 -->
<!-- 온라인 방식 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<div  class="outer">
			<div id="header">
					<a>
						<img src="/burgerstack/resources/images/BS_logo1.png">
					</a>
			</div>

			<br><br>

			<div align="center" id="sign">
				<h1>로그인</h1>
			</div>

			<br><br>


			<div class="login-area">
			
				<form id="login-form" action="/burgerstack/auth/login" method="post">
					<table>
						<tr id="login">
							<th>아이디</th>
							<td>
								<input type="text" name="userId" id="user-id-input" required>
							</td>
						</tr>
						<tr id="userPwd">
							<th>비밀번호</th>
							<td>
								<input type="password" name="password" id="password-input" required>
							</td>
						</tr>
						<tr id="saveId">
							<th>
								<input type="checkbox" name="saveId" id="">
								<label for="saveId">아이디 저장</label>
							</th>
							<td id="found">
								<a href="/burgerstack/auth/loginErrorPage">아이디 / 비밀번호 찾기</a>
							</td>
						</tr>
						
						
						
					</table>
						<button type="submit" class="btn btn-secondary btn-sm" id="loginbutton">
							로그인
						</button>
						
						<div id="loginMessage">
							
						</div>
						
				</form>
				
			</div>	

			<br><br>

		</div>

			<div class="footer">
					문의<br>
					이메일 :burgerstack@gmail.com <br>
					전화번호 :02)1234-1234
			</div>

		
	</div>
	
	<script>
		$(function() {
			$("#loginbutton").click(function(e) {
				e.preventDefault();
				
				$.ajax({
				  url : "/burgerstack/auth/login",
				  type : "post",
				  data : { 
					       userId : $("#user-id-input").val(), 
					       password : $("#password-input").val()
					     },
				  success : function(result){
								if(result.success){
									location.href = result.redirectUrl;
									return ;
								}
					
								$("#loginMessage").text(result.message);
							}
				})
			});
			
		});
	</script>
    <t:alertify />
</body>
</html>