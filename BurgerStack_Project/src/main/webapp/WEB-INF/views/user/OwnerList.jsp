<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점주 계정 목록 조회</title>

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

</style>

</head>
<body>

<t:menubarHO>

    <h1>점주 계정 목록 조회</h1>

    <div class="content">

        <div class="search-area">

            <select name="status">
                <option value="">전체상태</option>
                <option value="ACTIVE">사용중</option>
                <option value="INACTIVE">정지</option>
            </select>

            <input type="text"
                   name="keyword"
                   placeholder="아이디 또는 이름 검색">

            <button>검색</button>

        </div>

        <table>

            <thead>
                <tr>
                    <th>번호</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>연락처</th>
                    <th>이메일</th>
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

                            <tr>

                                <td>${u.userNo}</td>

                                <td>
                                    <a class="user-link"
                                       href="ownerDetail.ad?userNo=${u.userNo}">
                                        ${u.userId}
                                    </a>
                                </td>

                                <td>${u.userName}</td>

                                <td>${u.phone}</td>

                                <td>${u.email}</td>

                                <td>
                                    <fmt:formatDate
                                        value="${u.createdAt}"
                                        pattern="yyyy-MM-dd"/>
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

                            </tr>

                        </c:forEach>

                    </c:otherwise>

                </c:choose>

            </tbody>

        </table>

    </div>

</t:menubarHO>

</body>
</html>