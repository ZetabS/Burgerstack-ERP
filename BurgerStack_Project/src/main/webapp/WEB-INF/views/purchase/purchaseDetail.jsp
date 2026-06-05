<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 목록 상세 조회</title>
<jsp:include page="../common/header.jsp" />
</head>
<body>

<t:menubarBO>

    <h2>발주 목록 상세 보기</h2>

    <br>


    <!-- 검색 -->
    <div class="search-area">
        <button class="file-export">
            파일로 내보내기 (.xlsx, .pdf)
        </button>
        <select>
            <option>필터링1</option>
            <option>재고 부족</option>
            <option>정상 재고</option>
        </select>

        <div class="search-box">
            <input type="text" placeholder="검색어 입력">
            <button class="search-btn">  
                    <img src="resources/images/search.png" alt="검색">
            </button>
        </div>
    </div>

    <table class="table2">
        <thead>
            <tr>
                <th><input type="checkbox"></th>
                <th>품목</th>
                <th>원가</th>
                <th>재고</th>
                <th>주문수량</th>
                <th>구매가격</th>
            </tr>
        </thead>

        <tbody>
            <tr>
                <td><input type="checkbox"></td>
                <td>발주된</td>
                <td>10000</td>
                <td>442</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>품목만</td>
                <td>10000</td>
                <td>214</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>거기서</td>
                <td>10000</td>
                <td>0</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>수정할거선택수정</td>
                <td>10000</td>
                <td>3</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>사각 버거 박스 B</td>
                <td>10000</td>
                <td>11</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>양상추</td>
                <td>10000</td>
                <td>442</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>양상추</td>
                <td>10000</td>
                <td>132</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>양상추</td>
                <td>10000</td>
                <td>234</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>양상추</td>
                <td>10000</td>
                <td>111</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>양상추</td>
                <td>10000</td>
                <td>2</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>트리플체다치즈</td>
                <td>10000</td>
                <td>423</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>양상추</td>
                <td>10000</td>
                <td>334</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>양상추</td>
                <td>10000</td>
                <td>223</td>
                <td>
                    <input type="number" value="20">
                </td>
                <td>200000</td>
            </tr>
        </tbody>
    </table>

    <br><br>

    <div class="bottom-area" >
        <div class="total-price-area">
            <div>총 결제금액</div>
            <h2>14,200,000 원</h2>
        </div>

        <div class="button-group">
            <button class="button-secondary">수정</button>
            <button class="button-danger">취소 요청</button>
        </div>
    </div>

</t:menubarBO>


</body>
</html>