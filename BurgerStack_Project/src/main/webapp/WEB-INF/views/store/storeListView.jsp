<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점포 목록 조회</title>
<style>
	.content {
		width : 100%;
		padding-top: 35px;
	}

	.content h1 {
		width: 1300px;
		margin: 0 auto 35px auto;
		font-size: 30px;
		font-weight: bold;
	}

	/* 검색 영역 */
	.search-area {
		width: 1300px;
		margin: 0 auto 15px auto;
		display: flex;
		justify-content: flex-end;
		align-items: center;
		gap: 8px;
	}

	.search-area select {
		width: 100px;
		height: 30px;
		border: 1px solid black;
		border-radius: 15px;
		padding-left: 10px;
	}

	.search-area input[type="date"]{
		height: 30px;
		border: 1px solid black;
		padding: 0 8px;
	}

	.search-box {
		display: flex;
		height: 30px;
	}

	.search-box input {
		width: 130px;
		border: 1px solid black;
		border-right: none;
		padding-left: 10px;
	}

	.search-btn {
		width: 35px;
		height: 30px;
		padding: 0;
		border: none;
		background-color: #60758f;

		display: flex;
		justify-content: center;
		align-items: center;

		cursor: pointer;
	}

	.search-btn img {
		width: 35px;
		height: 30px;
		display: block;
		object-fit: contain;
	}

	/* 테이블 */
	table {
		width: 1300px;
		margin: 0 auto;
		border-collapse: collapse;
		background-color: white;
		text-align: center;
		font-size: 13px;
	}

	thead tr {
		background-color: #19c765;
		height: 35px;
	}

	th {
		padding: 10px;
	}

	tbody tr {
		height: 38px;
		border-bottom: 1px solid #f1f1f1;
		cursor: pointer;
	}

	tbody tr:hover {
    	background-color: #f2f6ff;
	}

	/* 페이지네이션 */
	.pagination {
		width: 300px;
		margin: 20px auto;
		text-align: center;
		font-size: 20px;
	}

	.pagination span {
		margin: 0 5px;
		color: #3f83d1;
		cursor: pointer;
	}

</style>
</head>
<body>
	<t:menubarHO>
		<div class="content"> 
			<h1>점포 목록 조회</h1>
		</div>
		
		<!-- 검색 -->
		<div class="search-area">
		
			<select>
				<option>전체상태</option>
				<option>영업중</option>
				<option>휴업</option>
				<option>폐점</option>
			</select>
			
			<input type="date" id="startDate">

			<input type="date" id="endDate"> 
			
			<div class="search-box">
				<input type="text" placeholder="검색어 입력">

				<button class="search-btn">  
					<img src="${pageContext.request.contextPath}/resources/images/search.png" alt="검색">
				</button>
			</div>

			
		</div>
		
		<!-- 테이블 생성 -->
		<table>
			<thead>
				<tr>
					<th>점포코드</th>
					<th>점포명</th>
					<th>주소</th>
					<th>연락처</th>
					<th>상태</th>
					<th>오픈일</th>
				</tr>
			</thead>
			
			<tbody>
				<tr onclick="location.href='${pageContext.request.contextPath}/store/detail?storeCode=110'">
					<td>110</td>
					<td>역삼B</td>
					<td>서울특별시 강남구 테헤란로14길 6 남도빌딩</td>
					<td>010-1111-2222</td>
					<td>영업중</td>
					<td>2026.02.25</td>
				</tr>
				
				<tr onclick="location.href='${pageContext.request.contextPath}/store/detail?storeCode=111'">
					<td>111</td>
					<td>강남A</td>
					<td>서울특별시 강남구 테헤란로14길 6 남도빌딩</td>
					<td>010-1111-3333</td>
					<td>폐점</td>
					<td>2026.02.26</td>
				</tr>
				
				<tr onclick="location.href='${pageContext.request.contextPath}/store/detail?storeCode=112'">
					<td>112</td>
					<td>강남H</td>
					<td>서울특별시 강남구 테헤란로14길 6 남도빌딩</td>
					<td>010-1111-4444</td>
					<td>영업중</td>
					<td>2026.02.27</td>
				</tr>
				
				<tr onclick="location.href='${pageContext.request.contextPath}/store/detail?storeCode=113'">
					<td>113</td>
					<td>강남H</td>
					<td>서울특별시 강남구 테헤란로14길 6 남도빌딩</td>
					<td>010-1111-5555</td>
					<td>영업중</td>
					<td>2026.02.28</td>
					
				</tr>
				
				<tr onclick="location.href='${pageContext.request.contextPath}/store/detail?storeCode=114'">
					<td>114</td>
					<td>강남H</td>
					<td>서울특별시 강남구 테헤란로14길 6 남도빌딩</td>
					<td>010-1111-6666</td>
					<td>휴업</td>
					<td>2026.02.29</td>
					
				</tr>
				
				
				
				
			</tbody>
		
		
		</table>
		
		<!-- 페이지네이션 -->
		<!-- 페이징네이션 -->
		<div class="pagination">
		
		    <c:if test="${pi.currentPage > 1}">
		        <a href="${pageContext.request.contextPath}/store/list?currentPage=1">
		            &lt;&lt;
		        </a>
		
		        <a href="${pageContext.request.contextPath}/store/list?currentPage=${pi.currentPage - 1}">
		            &lt;
		        </a>
		    </c:if>
		
		    <c:forEach var="p"
		               begin="${pi.startPage}"
		               end="${pi.endPage}">
		
		        <c:choose>
		
		            <c:when test="${p eq pi.currentPage}">
		                <span class="current-page">${p}</span>
		            </c:when>
		
		            <c:otherwise>
		                <a href="${pageContext.request.contextPath}/store/list?currentPage=${p}">
		                    ${p}
		                </a>
		            </c:otherwise>
		
		        </c:choose>
		
		    </c:forEach>
		
		    <c:if test="${pi.currentPage < pi.maxPage}">
		        <a href="${pageContext.request.contextPath}/store/list?currentPage=${pi.currentPage + 1}">
		            &gt;
		        </a>
		
		        <a href="${pageContext.request.contextPath}/store/list?currentPage=${pi.maxPage}">
		            &gt;&gt;
		        </a>
		    </c:if>
		
		</div>
	</t:menubarHO>
	
	

</body>
</html>