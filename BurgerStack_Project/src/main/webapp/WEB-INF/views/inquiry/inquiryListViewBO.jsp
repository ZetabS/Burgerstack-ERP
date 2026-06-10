<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항 목록 조회</title>

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
</style>

</head>
<body>

<t:layout>

    <h1>점주 계정 목록 조회</h1>

    <div class="content">

        <div class="search-area">

            <select name="status">
                <option value="">전체상태</option>
                <option value="ACTIVE">답변 완료</option>
                <option value="INACTIVE">미답변</option>
            </select>

            <input type="text"
                   name="keyword"
                   placeholder="아이디 또는 이름 검색">

            <button>검색</button>

        </div>
		<table>
			    <colgroup>
			        <col style="width:7%">
			        <col style="width:13%">
			        <col style="width:30%">
			        <col style="width:15%">
			        <col style="width:15%">
			        <col style="width:20%">
			    </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>연락처</th>
                    <th>이메일</th>
                    <th>등록일</th>
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

                            <tr>

                                <td>${u.userNo}</td>

								<td>
								    <a class="user-link"
								       href="/burgerstack/admin/users/${u.userId}">
								        ${u.userId}
								    </a>
								</td>

                                <td>${u.userName}</td>

                                <td>${u.phone}</td>

                                <td>${u.email}</td>

                                <td>${u.createdAt}</td>

                                <td>
                                    <c:choose>

                                        <c:when test="${u.status eq 'ACTIVE'}">
                                            답변 완료
                                        </c:when>

                                        <c:otherwise>
                                            미답변
                                        </c:otherwise>

                                    </c:choose>
                                </td>
                                
								<td>${u.createdAt}</td>
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