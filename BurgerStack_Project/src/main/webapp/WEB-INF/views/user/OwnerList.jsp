<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점주 계정 목록 조회</title>

<style>
	.form-container {
	width: 100%;
	max-width: 2000px;
	background: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}
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

    .user-link{
        text-decoration:none;
        color:black;
        font-weight:bold;
    }

    .user-link:hover{
        color:green;
    }
	table{
	    width:100%;
	    border-collapse:collapse;
	    table-layout:fixed;
	}
	
	th,
	table th,
	table td{
	    text-align:center !important;
	    vertical-align:middle !important;
	}
	.status-badge{
    display:inline-block;
    padding:5px 12px;
    border-radius:20px;
    font-size:12px;
    font-weight:bold;
    color:white;
	}
	
	.status-active{
	    background:#28a745;
	}
	
	.status-inactive{
	    background:#dc3545;
	}
	tbody tr{
    cursor:pointer;
    transition:0.2s;
	}
	
	tbody tr:hover{
	    background:#f5f5f5;
	}
</style>

</head>
<body>

<t:layout>

    <h1>점주 계정 목록 조회</h1>

    <div class="content">

		<form action="/burgerstack/admin/users" method="get">
		
		    <div class="search-area">
		
			<select name="status">
			    <option value="" ${empty param.status ? 'selected' : ''}>
			        전체상태
			    </option>
			
			    <option value="ACTIVE"
			        ${param.status eq 'ACTIVE' ? 'selected' : ''}>
			        영업중
			    </option>
			
			    <option value="INACTIVE"
			        ${param.status eq 'INACTIVE' ? 'selected' : ''}>
			        폐점
			    </option>
			</select>
			
			<input type="text"
			       name="keyword"
			       value="${param.keyword}"
			       placeholder="아이디 또는 이름 검색">
		
		        <button type="submit">검색</button>
		
		    </div>
		
		</form>
		<table class="form-container">
			    <colgroup>
			        <col style="width:20%">
			        <col style="width:20%">
			        <col style="width:20%">
			        <col style="width:20%">
			        <col style="width:20%">
			    </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>등록일</th>
                    <th>상태</th>
                </tr>
            </thead>

            <tbody>

                <c:choose>

                    <c:when test="${empty ownerList}">
                        <tr>
                            <td colspan="7">
                                조회된 점주 계정이 없습니다.
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                    
                        <c:forEach var="u" items="${ownerList}">

                            <tr onclick="location.href='/burgerstack/admin/users/${u.userId}'" style="cursor: pointer;">

                                <td>${u.displayNo}</td>

								<td>${u.userId}</td>

                                <td>${u.userName}</td>

                                <td>${fn:replace(user.createdAt, 'T', ' ')}</td>

								<td>
								    <c:choose>
								        <c:when test="${u.status eq 'ACTIVE'}">
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

                        </c:forEach>

                    </c:otherwise>

                </c:choose>

            </tbody>

        </table>

    </div>

</t:layout>

</body>
</html>