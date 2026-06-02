<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

    <!-- 항상 모든 페이지 상단에는 menubar.jsp 가 보여지게끔 include -->
	<%--<jsp:include page="common/menubarHO.jsp" />--%>
    


    <t:menubarBO>
    <div class="outer" align="center">
        <h1>요청 발주 상세조회</h1>
        <div class="filter" align="right">
            <button>파일로 내보내기(.xlsx,.pdf)</button>
            상태 : <label for="">요청중</label>
            <select name="sort" id="purchaseSort">
                <option value="" selected disabled hidden>정렬 필터링</option>
                <option>재고 많은 순</option>
                <option>재고 적은 순</option>
                
                <option>주문 많은 순</option>
                <option>주문 적은 순</option>

                <option>원가 높은 순</option>
                <option>원가 낮은 순</option>

                <option>구매가 높은 순</option>
                <option>구매가 낮은 순</option>
            </select>
            <input type="text" placeholder="검색어 입력">
            <button type="button" onclick="alert('클릭!')">
                <img src="..\..\..\resources\images\BS_logo2.png" style="width: 16px;"/>
                검색
            </button>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>품목</th>
                    <th>원가</th>
                    <th>재고</th>
                    <th>주문수량</th>
                    <th>구매가격</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>양상추</td>
                    <td>100,000</td>
                    <td>999912</td>
                    <td>20</td>
                    <td>2,000,000</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>토마토</td>
                    <td>100,000</td>
                    <td>999912</td>
                    <td>20</td>
                    <td>2,000,000</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>레귤러 번</td>
                    <td>100,000</td>
                    <td>999912</td>
                    <td>20</td>
                    <td>2,000,000</td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>양파</td>
                    <td>100,000</td>
                    <td>999912</td>
                    <td>20</td>
                    <td>2,000,000</td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>아메리칸치즈</td>
                    <td>100,000</td>
                    <td>999912</td>
                    <td>20</td>
                    <td>2,000,000</td>
                </tr>
            </tbody>
        </table>

        <div class="bottom">
            <table>
                <tr>
                    <td>총 결제금액</td>
                    <td rowspan="2">
                        <select id="purchaseDeny">
                            <option value="" selected disabled hidden>반려사유</option>
                            <option>단가 오류</option>
                            <option>재고 부족</option>
                            <option>중복 요청</option>
                            <option>수량 수정 필요</option>
                            <option>예산 초과</option>
                        </select>
                    </td>
                    <td rowspan="2">
                        <button>반려</button>
                    </td>
                    <td rowspan="2">
                        <button>승인</button>
                    </td>
                </tr>
                <tr>
                    <td>10,000,000</td>
                </tr>
            </table>
        </div>

    </div>
    </t:menubarBO>
</body>
</html>