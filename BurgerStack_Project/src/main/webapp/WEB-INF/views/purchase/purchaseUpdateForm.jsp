<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 수정 페이지 조회</title>
</head>
<main>
<main class="content-wrap">
    <section class="purchase-request-area">
        <h1>발주 수정 페이지</h1>
    </section>

    <!-- 검색 / 필터 -->
    <div class="search-area">
        <select name="requestStatus"> 
            <option value="">전체상태</option>
            <option value="REQUEST">요청중</option>
            <option value="APPROVE">승인</option>
            <option value="REJECT">반려</option>
            <option value="CANCEL">취소</option>
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

    <!-- 발주 요청 목록 테이블 -->
    <table class="purchase-request-table" >
        <thead>
            <tr>
                <th><input type="checkbox"></th>
                <th>요청번호</th>
                <th>지점명</th>
                <th>요청상태</th>
                <th>총 요청금액</th>
                <th>요청일</th>
                <th>처리상태</th>
            </tr>
        </thead>

        <tbody>
            <tr onclick="goUpdatePage('PG-1111')">
                <th><input type="checkbox" onclick="event.stopPropagation();"></th>
                <td>PG-1111</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
            </tr>

            <tr onclick="goUpdatePage('PG-1112')">
                <th><input type="checkbox" onclick="event.stopPropagation();"></th>
                <td>PG-1112</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
            </tr>

            <tr onclick="goUpdatePage('PG-1113')">
                <th><input type="checkbox" onclick="event.stopPropagation();"></th>
                <td>PG-1113</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
            </tr>

            <tr onclick="goUpdatePage('PG-1114')">
                <th><input type="checkbox" onclick="event.stopPropagation();"></th>
                <td>PG-1114</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
            </tr>

            
        </tbody>
    </table>

    <br>
    <!-- 페이지네이션 -->
	<div class="pagination">
		<span>&lt;&lt;</span>
		<span>&lt;</span>
		<span>1</span>
		<span>2</span>
		<span>3</span>
        
        
		<span>&gt;</span>
        <span>&gt;&gt;</span>
	</div>

    <script>
    function goUpdatePage(requestNo) {
        location.href = "<%= request.getContextPath() %>/purchase/purchaseRequestUpdate?requestNo=" + requestNo;
    }
    </script>
</main>
</body>
</html>