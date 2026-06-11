<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
    table input {
        width: 60px;
    }

    .table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
    }

    .table th,
    .table td {
        border-bottom: 1px solid #e5e7eb;
        padding: 12px;
        text-align: center;
        vertical-align: middle;
    }

    .table thead th {
        border-top: 1px solid #e5e7eb;
        border-bottom: 2px solid #d1d5db;
        font-weight: 700;
    }

    .search-area {
        margin-bottom: 18px;
    }

    .receive-info {
        margin-bottom: 18px;
    }

    .total-price {
        font-weight: 700;
        color: #ff6b00;
    }

    .btn-area {
        margin-top: 25px;
        text-align: center;
    }

    .btn-area button {
        padding: 7px 16px;
        border-radius: 6px;
        border: 1px solid #d1d5db;
        cursor: pointer;
    }

    .btn-area button[type="submit"] {
        background: #ff6b00;
        color: white;
        border: none;
        font-weight: 600;
    }
</style>
</head>

<body>
<t:layout>

    <h2>입고 처리</h2>

    <!-- 검색 -->
    <div class="search-area" align="right">
        <select name="type" id="materialsType">
            <option>전체</option>
            <option>상온</option>
            <option>냉장</option>
            <option>냉동</option>
            <option>건자재</option>
        </select>

        <input type="text" placeholder="검색어 입력">

        <button type="button" onclick="alert('클릭!')">
            <img src="${pageContext.request.contextPath}/resources/images/BS_logo2.png"
                 style="width: 16px;" />
            검색
        </button>
    </div>

    <!-- 입고 정보 -->
    <div class="receive-info">
        <table>
            <tr>
                <td>발주번호 : ${purchaseId}</td>
                <td>상태 :
                    <c:choose>
                        <c:when test="${purchaseStatus eq 'APPROVED'}">승인</c:when>
                        <c:when test="${purchaseStatus eq 'PARTIALLY_APPROVED'}">부분 승인</c:when>
                        <c:otherwise>${purchaseStatus}</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>
    </div>

    <!-- 입고 처리 데이터 표시 -->
    <form action="${pageContext.request.contextPath}/owner/purchases/${purchaseId}/receipt"
          method="post"
          align="center">

        <table class="table" align="center">
            <thead>
                <tr>
                    <th>상품코드</th>
                    <th>상품유형</th>
                    <th>상품명</th>
                    <th>발주수량</th>
                    <th>승인수량</th>

                    <c:if test="${purchaseStatus eq 'PARTIALLY_APPROVED'}">
                        <th>반려수량</th>
                        <th>반려사유</th>
                    </c:if>

                    <th>정상입고수량</th>
                    <th>불량수량</th>
                    <th>불량사유</th>
                    <th>단가</th>
                    <th>금액</th>
                </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${empty itemList}">
                        <tr>
                            <td colspan="${purchaseStatus eq 'PARTIALLY_APPROVED' ? 12 : 10}" align="center">
                                입고 처리할 품목이 없습니다.
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="item" items="${itemList}" varStatus="status">
                            <tr>
                                <td>${item.materialCode}</td>
                                <td>${item.materialType}</td>
                                <td>${item.materialName}</td>

                                <td>${item.requestQuantity}</td>
                                <td>${item.approvedQuantity}</td>

                                <c:if test="${purchaseStatus eq 'PARTIALLY_APPROVED'}">
                                    <td>${item.rejectedQuantity}</td>
                                    <td>${item.rejectReason}</td>
                                </c:if>

                                <td>
                                    <input type="hidden"
                                           name="items[${status.index}].purchaseOrderItemId"
                                           value="${item.purchaseOrderItemId}">

                                    <input type="number"
                                           class="received-qty"
                                           name="items[${status.index}].receivedQuantity"
                                           value="${item.approvedQuantity}"
                                           min="0"
                                           max="${item.approvedQuantity}"
                                           data-price="${item.supplyPrice}">
                                </td>

                                <td>
                                    <input type="number"
                                           class="defect-qty"
                                           name="items[${status.index}].defectQuantity"
                                           value="0"
                                           min="0"
                                           max="${item.approvedQuantity}">
                                </td>

                                <td>
                                    <select name="items[${status.index}].receiptItemMemo"
                                            class="defect-reason"
                                            disabled>
                                        <option value="">선택</option>
                                        <option value="파손">파손</option>
                                        <option value="변질">변질</option>
                                        <option value="수량 불일치">수량 불일치</option>
                                        <option value="기타">기타</option>
                                    </select>
                                </td>

                                <td>${item.supplyPrice}원</td>

                                <td class="row-amount">
                                    ${item.amount}원
                                </td>
                            </tr>
                        </c:forEach>

                        <tr>
                            <th>총 금액</th>
                            <td align="right"
                                colspan="${purchaseStatus eq 'PARTIALLY_APPROVED' ? 11 : 9}">
                                <span id="totalPrice" class="total-price">0원</span>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div class="btn-area">
            <button type="reset">초기화</button>
            <button type="submit">저장</button>
        </div>
    </form>

</t:layout>

<script>
    function calculateTotal() {
        let total = 0;

        document.querySelectorAll(".received-qty").forEach(function(input) {
            let row = input.closest("tr");

            let qty = Number(input.value || 0);
            let max = Number(input.getAttribute("max") || 0);
            let price = Number(input.dataset.price || 0);

            if (qty < 0) {
                qty = 0;
                input.value = 0;
            }

            if (qty > max) {
                qty = max;
                input.value = max;
            }

            let amount = qty * price;

            let amountCell = row.querySelector(".row-amount");
            if (amountCell) {
                amountCell.innerText = amount.toLocaleString() + "원";
            }

            total += amount;
        });

        let totalPrice = document.getElementById("totalPrice");
        if (totalPrice) {
            totalPrice.innerText = total.toLocaleString() + "원";
        }
    }

    document.addEventListener("input", function(e) {
        if (e.target.classList.contains("received-qty")) {
            calculateTotal();
        }

        if (e.target.classList.contains("defect-qty")) {
            let defectInput = e.target;
            let row = defectInput.closest("tr");
            let reasonSelect = row.querySelector(".defect-reason");

            let defectQty = Number(defectInput.value || 0);
            let max = Number(defectInput.getAttribute("max") || 0);

            if (defectQty < 0) {
                defectQty = 0;
                defectInput.value = 0;
            }

            if (defectQty > max) {
                defectQty = max;
                defectInput.value = max;
            }

            if (defectQty >= 1) {
                reasonSelect.disabled = false;
                reasonSelect.required = true;
            } else {
                reasonSelect.value = "";
                reasonSelect.disabled = true;
                reasonSelect.required = false;
            }
        }
    });

    document.querySelector("form").addEventListener("submit", function(e) {
        let valid = true;

        document.querySelectorAll(".defect-qty").forEach(function(input) {
            let row = input.closest("tr");
            let reasonSelect = row.querySelector(".defect-reason");

            let defectQty = Number(input.value || 0);

            if (defectQty >= 1 && !reasonSelect.value) {
                alert("불량수량이 있는 품목은 불량사유를 선택해야 합니다.");
                reasonSelect.focus();
                valid = false;
            }
        });

        if (!valid) {
            e.preventDefault();
        }
    });

    document.addEventListener("DOMContentLoaded", function() {
        calculateTotal();
    });
</script>

</body>
</html>