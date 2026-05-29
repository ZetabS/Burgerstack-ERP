<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../common/header.jsp" />
</head>
<body>
    <t:menubarBO>
        <h2>입고 이력 상세 보기</h2>

        <!-- 검색 -->
        <div class="search-area" align="right">
            <select name="status" id="purchaseStatus">
                <option>전체</option>
                <option>요청중</option>
                <option>완료</option>
            </select>
            <input type="text" placeholder="검색어 입력">
            <button type="button" onclick="alert('클릭!')">
                <img src="..\..\resources\images\BS_logo2.png" style="width: 16px;"/>
                검색
            </button>                
        </div>
	
        <div class="receive-info">
            <table>
                <tr>
                    <td>
                        입고 번호 : ${requestScope.receiveId}
                    </td>
                    <td>
                        승인 담당자 : ${requestScope.receiveDate}
                    </td>
                </tr>
            </table>
            
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>자재 코드</th>
                    <th>자재명</th>
                    <th>자재 유형</th>
                    <th>단가</th>
                    <th>요청 수량</th>
                    <th>실수령 수량</th>
                    <th>불량 수량</th>
                    <th>불량 사유</th>
                    <th>금액</th>
                </tr>
            </thead>
            
            <tbody>
                <tr>
                    <td>FF133</td>
                    <td>토마토</td>
                    <td>냉장</td>
                    <td>640</td>
                    <td>10</td>
                    <td>10</td>
                    <td>0</td>
                    <td>-</td>
                    <td>6400</td>
                </tr>
                <tr>
                    <td>FF123</td>
                    <td>양상추</td>
                    <td>냉장</td>
                    <td>640</td>
                    <td>10</td>
                    <td>12</td>
                    <td>0</td>
                    <td>-</td>
                    <td>6400</td>
                </tr>
                <tr>
                    <td>ICE121</td>
                    <td>레귤러 번</td>
                    <td>냉동</td>
                    <td>500</td>
                    <td>10</td>
                    <td>8</td>
                    <td>2</td>
                    <td>변질</td>
                    <td>4000</td>
                </tr>
                <tr>
                    <th>총금액</th>
                    <td align="right" colspan="8">16800원</td>
                </tr>        
            </tbody>
        
        
        </table>
	</t:menubarBO>
</body>
</html>