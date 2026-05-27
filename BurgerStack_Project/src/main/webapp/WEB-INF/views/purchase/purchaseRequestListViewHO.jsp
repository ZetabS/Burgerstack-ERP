<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <!-- 항상 모든 페이지 상단에는 menubar.jsp 가 보여지게끔 include -->
	<jsp:include page="common/menubarHO.jsp" />

    <div class="outer" align="center">
        <h1>요청 발주 조회</h1>
        <div class="filter" align="right">
            <select name="status" id="purchaseStatus">
                <option>전체</option>
                <option>완료</option>
                <option>요청중</option>
            </select>
            <input type="date">
            ~
            <input type="date">
            <input type="text" value="검색어 입력">
            <button type="button" onclick="alert('클릭!')">
                <img src="..\..\..\resources\images\BS_logo2.png" style="width: 16px;"/>
                검색
            </button>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>발주번호</th>
                    <th>지점명</th>
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
                    <td>2026.05.27</td>
                    <td>결제완료</td>
                    <td></td>
                </tr>
                <tr>
                    <td>1111</td>
                    <td>강남H</td>
                    <td>요청중</td>
                    <td>150,000</td>
                    <td>2026.05.27</td>
                    <td>결제완료</td>
                    <td></td>
                </tr>
                <tr>
                    <td>1111</td>
                    <td>강남H</td>
                    <td>요청중</td>
                    <td>150,000</td>
                    <td>2026.05.27</td>
                    <td>결제완료</td>
                    <td></td>
                </tr><tr>
                    <td>1111</td>
                    <td>강남H</td>
                    <td>요청중</td>
                    <td>150,000</td>
                    <td>2026.05.27</td>
                    <td>결제완료</td>
                    <td></td>
                </tr>
                <tr>
                    <td>1111</td>
                    <td>강남H</td>
                    <td>요청중</td>
                    <td>150,000</td>
                    <td>2026.05.27</td>
                    <td>결제완료</td>
                    <td></td>
                </tr>
                <tr>
                    <td>1111</td>
                    <td>강남H</td>
                    <td>완료</td>
                    <td>150,000</td>
                    <td>2026.05.27</td>
                    <td>준비중</td>
                    <td></td>
                </tr>
                <tr>
                    <td>1111</td>
                    <td>강남H</td>
                    <td>완료</td>
                    <td>150,000</td>
                    <td>2026.05.27</td>
                    <td>승인</td>
                    <td>완료</td>
                </tr>
                <tr>
                    <td>1111</td>
                    <td>강남H</td>
                    <td>완료</td>
                    <td>150,000</td>
                    <td>2026.05.27</td>
                    <td>반려</td>
                    <td>지점 요청</td>
                </tr>
                <tr>
                    <td>1111</td>
                    <td>강남H</td>
                    <td>완료</td>
                    <td>150,000</td>
                    <td>2026.05.27</td>
                    <td>승인</td>
                    <td>완료</td>
                </tr>
            </tbody>
        </table>

        <div class="pagenation">
            &lt;
            1
            2
            3
            4
            5
            6
            &gt;
        </div>

    </div>
    



</body>
</html>