<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점포 목록 조회</title>
</head>
<body>
	<t:menubarHO>
		<div class="content"> 
			<h1>점포 조회</h1>
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
					<img src="resources/images/search.png" alt="검색">
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
				<tr>
					<th>110</th>
					<th>역삼B</th>
					<th>서울특별시 강남구 테헤란로14길 6 남도빌딩</th>
					<th>010-1111-2222</th>
					<th>영업중</th>
					<th>2026.02.25</th>
				</tr>
				
				<tr>
					<th>111</th>
					<th>강남A</th>
					<th>서울특별시 강남구 테헤란로14길 6 남도빌딩</th>
					<th>010-1111-3333</th>
					<th>폐점</th>
					<th>2026.02.26</th>
				</tr>
				
				<tr>
					<th>112</th>
					<th>강남H</th>
					<th>서울특별시 강남구 테헤란로14길 6 남도빌딩</th>
					<th>010-1111-4444</th>
					<th>영업중</th>
					<th>2026.02.27</th>
				</tr>
				
				<tr>
					<th>113</th>
					<th>강남H</th>
					<th>서울특별시 강남구 테헤란로14길 6 남도빌딩</th>
					<th>010-1111-5555</th>
					<th>영업중</th>
					<th>2026.02.28</th>
					
				</tr>
				
				<tr>
					<th>114</th>
					<th>강남H</th>
					<th>서울특별시 강남구 테헤란로14길 6 남도빌딩</th>
					<th>010-1111-6666</th>
					<th>휴업</th>
					<th>2026.02.29</th>
					
				</tr>
				
				
				
				
			</tbody>
		
		
		</table>
		
		<!-- 페이지네이션 -->
		<div class="pagination">
			<span>&lt;&lt;</span>
			<span>&lt;</span>

			<span>1</span>
			<span>2</span>
			<span>3</span>
			<span>4</span>
			<span>5</span>
			<span>6</span>
			<span>7</span>
			<span>8</span>
			<span>9</span>
			<span>10</span>
			
			<span>&gt;</span>
			<span>&gt;&gt;</span>
		</div>
	</t:menubarHO>
	
	

</body>
</html>