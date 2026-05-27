<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 요청 등록</title>
</head>
<body>
<div class="content"> 
		<h1>발주 요청 등록</h1>
	</div>

<!-- 검색 -->
<div class="search-area">
    <select>
        <option>정렬 필터링</option>
        <option>재고 부족순</option>
        <option>재고 많은순</option>
        <option>구매가 높은순</option>
        <option>구매가 낮은순</option>
        <option>주문 수량순</option>
        <option>선택 항목만 보기</option>
    </select>

    <div class="search-box">
		<input type="text" placeholder="검색어 입력">
		<button class="search-btn">  
				<img src="resources/images/search.png" alt="검색">
		</button>
	</div>
</div>

<table border="1">
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
            <td>양상추</td>
            <td>10000</td>
            <td>442</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>214</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>200000</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>0</td>
            <td>
                <input type="number" value="20">
            </td>
            <td>200000</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>3</td>
            <td>
                <input type="number" value="25">
            </td>
            <td>200000</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>11</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>442</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>132</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>234</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>111</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>2</td>
            <td>
                <input type="number" value="30">
            </td>
            <td>200000</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>423</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>334</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>223</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>113</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>21</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>

        <tr>
            <td><input type="checkbox"></td>
            <td>양상추</td>
            <td>10000</td>
            <td>93</td>
            <td>
                <input type="number" value="0">
            </td>
            <td>0</td>
        </tr>
    </tbody>

</table>

<aside class="material-purchase-list-box">
    <h2>요청 리스트</h2>

    <table class="material-purchase-list-table">
        <thead>
            <tr>
                <th><input type="checkbox"></th>
                <th>품목</th>
                <th>수량</th>
                <th>구매가격</th>
            </tr>

            <tr>
                <th><input type="checkbox"></th>
                <th>양상추</th>
                <th>20</th>
                <th>200000</th>
            </tr>

            <tr>
                <th><input type="checkbox"></th>
                <th>양상추</th>
                <th>20</th>
                <th>200000</th>
            </tr>

            <tr>
                <th><input type="checkbox"></th>
                <th>양상추</th>
                <th>20</th>
                <th>200000</th>
            </tr>

            <tr>
                <th><input type="checkbox"></th>
                <th>양상추</th>
                <th>20</th>
                <th>200000</th>
            </tr>

            <tr>
                <th><input type="checkbox"></th>
                <th>양상추</th>
                <th>20</th>
                <th>200000</th>
            </tr>

            <tr>
                <th><input type="checkbox"></th>
                <th>양상추</th>
                <th>20</th>
                <th>200000</th>
            </tr>
        </thead>
    </table>

    <div class="payment-area">
        <p>총 요청 금액</p>
        <h3>14,200,000 원</h3>
        <button type="button" class="payment-area">
            요청 등록
        </button>

    </div>
</aside>



</body>
</html>