<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 요청 페이지 조회</title>
</head>
<body>

<main class="content-wrap">

    <section class="purchase-request-area">
        <h1>발주 요청 페이지</h1>
    </section>

    <div class="top-btn-area">
        <button onclick="goCreatePage()">발주 요청 등록</button>
    </div>

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
                <img src="<%= request.getContextPath() %>/resources/images/search.png" alt="검색">
            </button>
        </div>
    </div>

    <!-- 발주 요청 목록 테이블 -->
    <table class="purchase-request-table" border="2" width="60%">
        <thead>
            <tr>
                <th>요청번호</th>
                <th>지점명</th>
                <th>요청상태</th>
                <th>총 요청금액</th>
                <th>요청일</th>
                <th>처리상태</th>
                <th>상세조회</th>
            </tr>
        </thead>

        <tbody>
            <tr>
                <td>PG-1111</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
                <td><button onclick="goDetailPage('PG-1111')">상세조회</button></td>
            </tr>

            <tr>
                <td>PG-1112</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
                <td><button onclick="goDetailPage('PG-1112')">상세조회</button></td>
            </tr>

            <tr>
                <td>PG-1113</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
                <td><button onclick="goDetailPage('PG-1113')">상세조회</button></td>
            </tr>

            <tr>
                <td>PG-1114</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
                <td><button onclick="goDetailPage('PG-1114')">상세조회</button></td>
            </tr>

            <tr>
                <td>PG-1115</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
                <td><button onclick="goDetailPage('PG-1115')">상세조회</button></td>
            </tr>

            <tr>
                <td>PG-1116</td>
                <td>강남점</td>
                <td>요청중</td>
                <td>14,200,000</td>
                <td>2026.03.14</td>
                <td>대기</td>
                <td><button onclick="goDetailPage('PG-1116')">상세조회</button></td>
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

</main>

<script>
    function goCreatePage() {
        location.href = "<%= request.getContextPath() %>/purchase/purchaseRequestCreate";
    }

    function goDetailPage(requestNo) {
        location.href = "<%= request.getContextPath() %>/purchase/purchaseRequestDetail?requestNo=" + requestNo;
    }
</script>

</body>
</html>