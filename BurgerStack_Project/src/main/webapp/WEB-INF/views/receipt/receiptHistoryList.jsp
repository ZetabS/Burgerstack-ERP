<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common/header.jsp" />
</head>
<body>
    <t:menubarBO>
        <h2>입고 이력</h2>

        <!-- 검색 -->
        <div class="search-area" align="right">
            <select name="status" id="purchaseStatus">
                <option>전체</option>
                <option>요청일</option>
                <option>입고 완료일</option>
            </select>
            <input type="date">
            ~
            <input type="date">
            <input type="text" placeholder="검색어 입력">
            <button type="button" onclick="alert('클릭!')">
                <img src="..\..\resources\images\BS_logo2.png" style="width: 16px;"/>
                검색
            </button>                
        </div>
	
        <div class="receipt-info">
            <table>
                <tr>
                    <td>
                        매장명 : ${requestScope.storeId}
                    </td>
                    <td>
                        매장 담당자 : ${requestScope.receivedBy}
                    </td>
                </tr>
            </table>
            
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>입고번호</th>
                    <th>품목요약</th>
                    <th>총액</th>
                    <th>요청일</th>
                    <th>입고 완료일</th>
                    <th>승인 담당자</th>
                </tr>
            </thead>
            
            <tbody>   
                <tr>
                    <td>${requestScope.receipts.receiptId}</td>
                    <td>토마토 외 5건</td>
                    <td>150,000</td>
                    <td>${requestScope.receipts.receivedAT}</td>
                    <td>${requestScope.purchaseRequests.updatedAT}</td>
                    <td>${requestScope.receipts.receivedBy}</td>
                </tr>                
                <tr>
                    <td>1113</td>
                    <td>토마토 외 2건</td>
                    <td>150,000</td>
                    <td>2026.02.25</td>
                    <td>2026.02.25</td>
                    <td>점장</td>
                </tr>
                
                <tr>
                    <td>1114</td>
                    <td>토마토 외 5건</td>
                    <td>150,000</td>
                    <td>2026.02.25</td>
                    <td>2026.02.27</td>
                    <td>점장</td>
                </tr>          
            </tbody>
        
        
        </table>

        <ui:pagination pageInfo="${pageInfo}"></ui:pagination>

	</t:menubarBO>

    <script>

        
    </script>

</body>
</html>