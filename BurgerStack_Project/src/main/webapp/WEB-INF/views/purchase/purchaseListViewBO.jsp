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
				<td>1111</td>
				<td>강남H</td>
				<td>요청중</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>결제완료</td>
				<td>-</td>
			</tr>
			
			<tr>
				<td>1112</td>
				<td>강남H</td>
				<td>요청중</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>준비중</td>
				<td>-</td>
			</tr>
			
			<tr>
				<td>1113</td>
				<td>강남H</td>
				<td>완료</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>반려</td>
				<td>지점 요청</td>
			</tr>
			
			<tr>
				<td>1114</td>
				<td>강남H</td>
				<td>완료</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>반려</td>
				<td>미판매 항목 포함</td>
			</tr>
			
			<tr>
				<td>1115</td>
				<td>강남H</td>
				<td>완료</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>승인</td>
				<td>완료</td>
			</tr>
			
			<tr>
				<td>1116</td>
				<td>강남H</td>
				<td>완료</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>승인</td>
				<td>완료</td>
			</tr>
			
			<tr>
				<td>1117</td>
				<td>강남H</td>
				<td>완료</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>결제완료</td>
				<td>완료</td>
			</tr>
			
			<tr>
				<td>1118</td>
				<td>강남H</td>
				<td>완료</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>결제완료</td>
				<td>완료</td>
			</tr>
			
			<tr>
				<td>1119</td>
				<td>강남H</td>
				<td>완료</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>결제완료</td>
				<td>완료</td>
			</tr>
			
			<tr>
				<td>1120</td>
				<td>강남H</td>
				<td>완료</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>결제완료</td>
				<td>완료</td>
			</tr>
			
			<tr>
				<td>1121</td>
				<td>강남H</td>
				<td>완료</td>
				<td>150,000</td>
				<td>2026.02.25</td>
				<td>결제완료</td>
				<td>완료</td>
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