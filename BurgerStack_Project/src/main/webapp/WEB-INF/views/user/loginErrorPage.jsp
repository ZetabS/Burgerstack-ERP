<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
	<style type="text/css">
	#header{
    	text-align:center;
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
		color:darkgray;
	}
	
	#login-form input[type=text],
	#login-form input[type=password]{
		width:220px;
		height:32px;
		border:1px solid lightgray;
	}

	.login-button{
		margin: auto;
		border-radius: 10px;
		border: 1px solid lightgray;
		width: 300px;
		background-color: coral;
		color: white;
	}
	label{
		font-size:12px;
	}
	#found{
		padding-left: 70px;
		padding-bottom: 5px;

	}
    .footer{
		width: 500px;
		margin: auto;
		text-align: center;  
        font-size: 17px;      
        font-weight: 700;
    }
	.footer_1{
		width: 250px;
		margin: auto;
		text-align: center;
        font-weight: 700;
	}
    .footer_2{
		width: 250px;
		margin: auto;
		text-align: center;
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
					<img src="/BurgerStack_Project/src/main/webapp/resources/images/BS_logo1.png" alt="">
				</a>
			</div>

			<br><br>

			<div align="center" id="sign">
				<h2>아이디 / 비밀번호 찾기</h2>
			</div>

			<br><br>

            <div class="footer">
                해당 지역 담당 FM에게 연락주세요.
            </div>
            <br><br>

			<div class="footer_1">
                    본사 문의 <br>
			</div>

            
			<div class="footer_2">
                    02)1234-1234 <br>
                    burgerstack@gmail.com
			</div>

			<br><br>

			<div class="login-button" align="center" onclick="">
				<h2>홈으로 돌아가기</h2>
				<!-- <a href="" align="center"><h3>로그인</h3></a> -->
			</div>

		</div>
			
		
	</div>
</body>
</html>