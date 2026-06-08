<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BurgerStack</title>
<link rel="shortcut icon" type="image/x-icon" href="/resources/images/BS_logo2.png" />
<style type="text/css">
	.page-title{
    font-weight:700;
    margin-bottom:20px;
    }

    .mypage-wrap{
        width:700px;
        margin:0 auto;
    }

    .section-title{
        margin-top:40px;
        margin-bottom:15px;
        font-weight:700;
    }

    .info-table{
        width:100%;
        border-collapse:collapse;
    }

    .info-table th{
        width:120px;
        text-align:left;
        padding:12px;
        font-size:14px;
    }

    .info-table td{
        padding:12px;
        font-size:14px;
    }

    .info-table input{
        width:250px;
        height:35px;
        border:1px solid #ccc;
        border-radius:4px;
        padding:0 10px;
    }

    .btn-area{
        margin-top:30px;
        text-align:center;
    }

    .btn-save,
    .btn-list{
        width:120px;
        height:45px;
        border:none;
        border-radius:8px;
        font-weight:600;
        cursor:pointer;
        margin:0 10px;
    }

    .btn-save{
        background:#1f2937;
        color:white;
    }

    .btn-list{
        background:#64748b;
        color:white;
    }
    .content-box{
        max-width:700px;
        margin:0 auto;
    }
    .table td,
    .table th {
        border-top: none !important;
        border-bottom: none !important;
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
	#newOwner{
		width: 1150px;
	}
</style>
</head>
<body>

	<t:menubarHO>
		<h3>계정 등록</h3>
                <hr>
                <form id="new" action="/burgerstack/admin/users" method="post">

                    <table class="table">
                        <tr>
                            <th width="20%">로그인 아이디</th>
                            <td>
                                <input type="text"
                                    name="userId"
                                    class="form-control"
                                    required>
                            </td>
                        </tr>

                        <tr>
                            <th>비밀번호</th>
                            <td>
                                <input type="password"
                                    name="password"
                                    class="form-control"
                                    required>
                            </td>
                        </tr>

                        <tr>
                            <th>이름</th>
                            <td>
                                <input type="text"
                                    name="userName"
                                    class="form-control"
                                    required>
                            </td>
                        </tr>

                        <tr>
                            <th>전화번호</th>
                            <td>
                                <input type="text"
                                    name="phone"
                                    class="form-control">
                            </td>
                        </tr>

                        <tr>
                            <th>이메일</th>
                            <td>
                                <input type="email"
                                    name="email"
                                    class="form-control">
                            </td>
                        </tr>
                    </table>

					<div class="text-center" id="newOwner">
                        <button type="submit" class="btn btn-primary">
                            계정 등록
                        </button>
                    </div>
		            <div class="home-btn-area">
			    		<button type="button" id="homeBtn" onclick="location.href = '/burgerstack/admin/dashboard'">
					        홈으로
					    </button>
					</div>
					
                </form>

		
	</t:menubarHO>

</body>
</html>