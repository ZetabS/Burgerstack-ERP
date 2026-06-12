<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>발주 목록 상세 조회</title>
<style>
    .content-top{
        display: flex;
    }
    .top-info {
        text-align: left;
        width: 200px;
    }
</style>

<!-- 레이아웃 작업 -->
<t:layout>

    <h2>발주 목록 상세 보기</h2>

    <br>


    <!-- 검색 -->
    <!-- <div class="search-area">
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
    </div> -->

    <table class="table2">
        <thead>
            <tr>
                <th>상품코드</th>
                <th>상품유형</th>
                <th>품목</th>
                <th>현 재고</th>
                <th>주문수량</th>
                <th>공급가</th>
                <th>구매가격</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="item" items="${list}">
                <tr class="item-row ${item.status eq 'REQUESTED' ? '' : 'disabled-row'}">
                    <td>${item.materialId}</td>

                    <td>${item.materialType}</td>

                    <td>${item.materialName}</td>

                    <td>${item.currentQuantity}</td>

                    <td>
                        <input type="number" value="${item.requestQuantity}" disabled>
                    </td>

                    <td class="comma-number">${item.supplyPriceSnapshot}</td>

                    <td class="comma-number">
                        <c:set var="rowTotal" value="${item.requestQuantity * item.supplyPriceSnapshot}" />
                        ${rowTotal}
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br><br>

    <div class="bottom-area" >
        <div class="total-price-area">
            <div>총 결제금액</div>
            <c:set var="total" value="0"/>
            <c:forEach var="item" items="${list}">
                <c:set var="rowTotal" value="${item.requestQuantity * item.supplyPriceSnapshot}" />
                <c:set var="total" value="${total + rowTotal}" />
            </c:forEach>
            <h2><span class="comma-number">${total}</span>원</h2>
        </div>

        <div class="button-group" style="display:flex; gap:10px; align-items:center;">
            <button type="button" class="button-secondary" onclick="location.href = '${pageContext.request.contextPath}/owner/purchases'"> 목록 </button>
            <c:choose>
                <c:when test="${list[0].status eq 'REQUESTED'}">
                    <button class="button-primary" onclick="location.href='${pageContext.request.contextPath}/owner/purchases/${list[0].purchaseOrderId}/edit'">
                        수정
                    </button>
                    <form action="${pageContext.request.contextPath}/owner/purchases/${list[0].purchaseOrderId}/cancel"
                    method="post">

                        <button class="button-danger" type="submit"
                                onclick="return confirm('발주를 취소하시겠습니까?')">
                            발주 취소
                        </button>

                    </form>
                </c:when>
                <c:otherwise>
                    <button class="button-secondary" disabled>수정 불가</button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</t:layout>

<script>
    // 금액 포멧팅
    // 클래스가 'comma-number'인 모든 태그 선택
    const elements = document.querySelectorAll('.comma-number');
    
    elements.forEach(el => {
        const num = Number(el.textContent);
        // 숫자가 맞을 때만 변경
        if (!isNaN(num)) {
        el.textContent = num.toLocaleString('ko-KR');
        }
    });
</script>