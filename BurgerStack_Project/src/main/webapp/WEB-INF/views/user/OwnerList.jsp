<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    table{
        width:100%;
        border-collapse: collapse;
    }

    th{
        background-color:#22c55e;
        color:white;
        height:40px;
    }

    td{
        text-align:center;
        height:40px;
        border-bottom:1px solid #ddd;
    }

    .search-area{
        display:flex;
        justify-content:flex-end;
        margin-bottom:15px;
        gap:10px;
    }

    .btn{
        border:none;
        padding:5px 10px;
        cursor:pointer;
    }
</style>
</head>
<body>

	<t:menubarHO>
	<h1>점주 계정 목록 조회</h1>
		<div class="content">
		
		    <h2>점주 계정 목록 조회</h2>
		
		    <div class="search-area">
		
		        <select name="status">
		            <option value="">전체상태</option>
		            <option value="Y">사용중</option>
		            <option value="N">정지</option>
		        </select>
		
		        <input type="text" name="keyword"
		               placeholder="아이디 또는 이름 검색">
		
		        <button>검색</button>
		
		    </div>
		
		    <table>
				<thead>
				    <tr>
				        <th>사용자번호</th>
				        <th>로그인ID</th>
				        <th>이름</th>
				        <th>연락처</th>
				        <th>이메일</th>
				        <th>등록일</th>
				        <th>상태</th>
				        <th>관리</th>
				    </tr>
				</thead>

		        <tbody>
		
		            <c:choose>
		
		                <c:when test="${empty ownerList}">
		                    <tr>
		                        <td colspan="8">
		                            조회된 점주가 없습니다.
		                        </td>
		                    </tr>
		                </c:when>
		
		                <c:otherwise>
		
		                    <c:forEach var="u" items="${ownerList}">
							<tr onclick="location.href='ownerDetail.ad?userId=${u.userId}'" style="cursor:pointer;">
							
							    <td>${u.userId}</td>
							
							    <td>${u.loginId}</td>
							
							    <td>${u.userName}</td>
							
							    <td>${u.phone}</td>
							
							    <td>${u.email}</td>
							
							    <td>
							        <fmt:formatDate value="${u.createdAt}"
							                        pattern="yyyy.MM.dd"/>
							    </td>
							
							    <td>
							        <c:choose>
							            <c:when test="${u.status eq 'ACTIVE'}">
							                사용중
							            </c:when>
							            <c:otherwise>
							                정지
							            </c:otherwise>
							        </c:choose>
							    </td>
							
							    <td>
							        <button class="btn"
							                onclick="location.href='updateOwnerForm.do?userId=${u.userId}'">
							            수정
							        </button>
							
							        <button class="btn"
							                onclick="stopOwner(${u.userId})">
							            정지
							        </button>
							    </td>
							
							</tr>
		
		                    </c:forEach>
		
		                </c:otherwise>
		
		            </c:choose>
		
		        </tbody>
		
		    </table>
		
		</div>
		
		<script>
		
		function stopOwner(userId){

		    if(confirm("해당 점주 계정을 정지하시겠습니까?")){

		        location.href="stopOwner.do?userId=" + userId;

		    }

		}
		
		</script>
	</t:menubarHO>

</body>
</html>