<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 목록 조회</title>
</head>
<body>
	<div class="content"> 
		<h1>발주 조회</h1>
	</div>
	
	<!-- 검색 -->
	<div class="search-area">
	
		<select>
			<option>전체상태</option>
			<option>요청중</option>
			<option>승인</option>
			<option>반려</option>
			<option>완료</option>
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
	
	<table>
		<thead>
			<tr>
				<th>발주번호</th>
				<th>지역명</th>
				<th>상태</th>
				<th>총액</th>
				<th>요청일</th>
				<th>진행상황</th>
				<th>사유</th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<th>1111</th>
				<th>강남H</th>
				<th>요청중</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>결제완료</th>
				<th>-</th>
			</tr>
			
			<tr>
				<th>1112</th>
				<th>강남H</th>
				<th>요청중</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>준비중</th>
				<th>-</th>
			</tr>
			
			<tr>
				<th>1113</th>
				<th>강남H</th>
				<th>완료</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>반려</th>
				<th>지점 요청</th>
			</tr>
			
			<tr>
				<th>1114</th>
				<th>강남H</th>
				<th>완료</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>반려</th>
				<th>미판매 항목 포함</th>
			</tr>
			
			<tr>
				<th>1115</th>
				<th>강남H</th>
				<th>완료</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>승인</th>
				<th>완료</th>
			</tr>
			
			<tr>
				<th>1116</th>
				<th>강남H</th>
				<th>완료</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>승인</th>
				<th>완료</th>
			</tr>
			
			<tr>
				<th>1117</th>
				<th>강남H</th>
				<th>완료</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>결제완료</th>
				<th>완료</th>
			</tr>
			
			<tr>
				<th>1118</th>
				<th>강남H</th>
				<th>완료</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>결제완료</th>
				<th>완료</th>
			</tr>
			
			<tr>
				<th>1119</th>
				<th>강남H</th>
				<th>완료</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>결제완료</th>
				<th>완료</th>
			</tr>
			
			<tr>
				<th>1120</th>
				<th>강남H</th>
				<th>완료</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>결제완료</th>
				<th>완료</th>
			</tr>
			
			<tr>
				<th>1121</th>
				<th>강남H</th>
				<th>완료</th>
				<th>150,000</th>
				<th>2026.02.25</th>
				<th>결제완료</th>
				<th>완료</th>
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
	

</body>
</html>