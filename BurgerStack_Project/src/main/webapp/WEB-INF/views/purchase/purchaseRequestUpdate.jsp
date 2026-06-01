<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>발주 요청 수정</title>
</head>
<body>
    <h2>점장- 발주 요청 수정</h2>

    <select>
        <option>정렬 필터링</option>
        <option>재고 부족순</option>
        <option>재고 많은순</option>
        <option>구매가 높은순</option>
        <option>구매가 낮은순</option>
        <option>발주 수량순</option>
        <option>선택 항목만 보기</option>
    </select>

    <div class="search-box">
		<input type="text" placeholder="검색어 입력">
		<button class="search-btn">  
				<img src="resources/images/search.png" alt="검색">
		</button>
	</div>

    <table border="1" width="100%">
        <thead>
            <tr>
                <th>선택</th>
                <th>품목</th>
                <th>원가</th>
                <th>재고</th>
                <th>주문수량</th>
                <th>구매가격</th>
                <th>상태</th>
            </tr>
        </thead>

        <tbody>
            <tr>
                <td><input type="checkbox"></td>
                <td>양상추</td>
                <td>10000</td>
                <td>3</td>
                <td><input type="number" value="25"></td>
                <td>250000</td>
                <td>요청중</td>
            </tr>

            <tr>
                <td><input type="checkbox"></td>
                <td>토마토</td>
                <td>10000</td>
                <td>8</td>
                <td><input type="number" value="8"></td>
                <td>80000</td>
                <td>요청중</td>
            </tr>
        </tbody>
    </table>

    <br>

    <div>
        <p>총 결제금액</p>
        <h3>330000원</h3>
    </div>

    <button type="button">수정</button>
    <button type="button">목록</button>
</body>
</html>