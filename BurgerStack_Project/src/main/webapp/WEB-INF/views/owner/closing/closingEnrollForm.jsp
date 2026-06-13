<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일일 재고 마감</title>

<style>
    .closing-card {
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        padding: 35px 40px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .section-title {
        margin-bottom: 12px;
        padding-left: 12px;
        border-left: 5px solid #19c765;
        font-size: 22px;
        font-weight: bold;
    }

    .guide-text {
        margin-bottom: 22px;
        color: #6b7280;
        font-size: 13px;
        line-height: 1.6;
    }

    .date-area {
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .date-label {
        font-weight: 700;
        color: #374151;
    }

    .date-value {
        display: inline-block;
        padding: 8px 14px;
        border-radius: 8px;
        background: #f3f4f6;
        border: 1px solid #e5e7eb;
        color: #111827;
        font-weight: 600;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
        font-size: 13px;
    }

    thead tr {
        background: #19c765;
        color: white;
        height: 42px;
    }

    th, td {
        padding: 12px 10px;
    }

    tbody tr {
        border-bottom: 1px solid #e5e7eb;
    }

    tbody tr:hover {
        background: #f2f6ff;
    }

    input[type="number"] {
        width: 90px;
        height: 32px;
        text-align: center;
        border: 1px solid #d1d5db;
        border-radius: 6px;
    }

    textarea {
        width: 100%;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 8px;
        resize: none;
    }

    .memo-area {
        margin-top: 20px;
    }

    .memo-area strong {
        display: inline-block;
        margin-bottom: 8px;
    }

    .submit-btn {
        margin-top: 20px;
        padding: 10px 20px;
        border: none;
        border-radius: 8px;
        background: #19c765;
        color: white;
        font-weight: bold;
        cursor: pointer;
    }

    .submit-btn:hover {
        background: #16a34a;
    }

    .remain-qty {
        font-weight: bold;
        color: #2563eb;
    }

    .reason-cell {
        background: #f8fafc;
        text-align: left;
        padding: 16px 20px;
    }

    .reason-cell strong {
        display: block;
        margin-bottom: 8px;
        color: #374151;
    }

    .reason-cell textarea {
        width: 100%;
        min-height: 70px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 10px;
        resize: none;
    }

    .danger-text {
        color: #dc2626;
        font-size: 12px;
        margin-top: 6px;
        display: none;
    }
</style>

</head>

<body>

<t:layout>

<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>

<section class="closing-card">

    <h2 class="section-title">일일 재고 마감</h2>

    <p class="guide-text">
        오늘 영업일 기준으로 재고를 마감합니다.
        실사용수량과 폐기 수량을 입력하면 잔여 수량이 자동 계산됩니다.
        폐기 수량이 1개 이상이면 폐기 사유를 반드시 입력해야 합니다.
    </p>

    <form action="${pageContext.request.contextPath}/owner/closings"
          method="post"
          onsubmit="return validateClosingForm();">

        <div class="date-area">
            <span class="date-label">영업일</span>
            <span class="date-value">${today}</span>

            <input type="hidden"
                   name="businessDate"
                   value="${today}">
        </div>

        <table>

            <thead>
                <tr>
                    <th>자재 유형</th>
                    <th>자재명</th>
                    <th>전산재고</th>
                    <th>실사용수량</th>
                    <th>폐기 수량</th>
                    <th>잔여 수량</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="inv" items="${inventoryList}">

                    <tr class="item-row">

                        <td>
                            <c:choose>
                                <c:when test="${inv.materialType eq 'AF'}">상온</c:when>
                                <c:when test="${inv.materialType eq 'RF'}">냉장</c:when>
                                <c:when test="${inv.materialType eq 'FF'}">냉동</c:when>
                                <c:when test="${inv.materialType eq 'PK'}">포장재</c:when>
                                <c:when test="${inv.materialType eq 'KW'}">주방용품</c:when>
                                <c:otherwise>${inv.materialType}</c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <span class="material-name">${inv.materialName}</span>

                            <input type="hidden"
                                   name="storeInventoryId"
                                   value="${inv.storeInventoryId}">

                            <input type="hidden"
                                   name="systemQuantity"
                                   value="${inv.currentQuantity}">

                            <input type="hidden"
                                   class="system-qty"
                                   value="${inv.currentQuantity}">

                            <input type="hidden"
                                   name="materialNameSnapshot"
                                   value="${inv.materialName}">
                        </td>

                        <td>${inv.currentQuantity}</td>

                        <td>
                            <input type="number"
                                   name="physicalQuantity"
                                   class="use-qty"
                                   value="0"
                                   min="0"
                                   required>
                        </td>

                        <td>
                            <input type="number"
                                   name="disposalQuantity"
                                   class="disposal-qty"
                                   value="0"
                                   min="0">
                        </td>

                        <td>
                            <span class="remain-qty">${inv.currentQuantity}</span>
                            <div class="danger-text">
                                실사용수량과 폐기 수량의 합은 전산재고보다 클 수 없습니다.
                            </div>
                        </td>

                    </tr>

                    <tr class="reason-row" style="display:none;">
                        <td colspan="6" class="reason-cell">
                            <strong>폐기 사유</strong>
                            <textarea name="closingItemMemo"
                                      class="disposal-reason"
                                      maxlength="100"
                                      placeholder="폐기 사유를 입력하세요."></textarea>
                        </td>
                    </tr>

                </c:forEach>

            </tbody>

        </table>

        <div class="memo-area">

            <strong>마감 메모</strong>

            <textarea name="closingMemo"
                      rows="5"
                      maxlength="300"
                      required
                      placeholder="마감 메모를 입력하세요."></textarea>

        </div>

        <button type="submit"
                class="submit-btn">
            마감하기
        </button>

    </form>

</section>

</t:layout>

<script>
    function updateRow(row) {
        const systemQty =
            Number(row.querySelector(".system-qty").value || 0);

        const useQty =
            Number(row.querySelector(".use-qty").value || 0);

        const disposalQty =
            Number(row.querySelector(".disposal-qty").value || 0);

        let remainQty = systemQty - useQty - disposalQty;

        const dangerText = row.querySelector(".danger-text");

        if (remainQty < 0) {
            remainQty = 0;
            dangerText.style.display = "block";
        } else {
            dangerText.style.display = "none";
        }

        row.querySelector(".remain-qty").innerText = remainQty;

        const reasonRow = row.nextElementSibling;
        const reason = reasonRow.querySelector(".disposal-reason");

        if (disposalQty > 0) {
            reasonRow.style.display = "";
            reason.required = true;
        } else {
            reasonRow.style.display = "none";
            reason.required = false;
            reason.value = "";
        }
    }

    function validateClosingForm() {
        const rows = document.querySelectorAll(".item-row");

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];

            const materialName = row.querySelector(".material-name").innerText.trim();

            const systemQty =
                Number(row.querySelector(".system-qty").value || 0);

            const useQty =
                Number(row.querySelector(".use-qty").value || 0);

            const disposalQty =
                Number(row.querySelector(".disposal-qty").value || 0);

            const reasonRow = row.nextElementSibling;
            const reason = reasonRow.querySelector(".disposal-reason");

            if (useQty + disposalQty > systemQty) {
                alert(materialName + "의 실사용수량과 폐기 수량의 합은 전산재고보다 클 수 없습니다.");
                row.querySelector(".use-qty").focus();
                return false;
            }

            if (disposalQty > 0 && reason.value.trim() === "") {
                alert(materialName + "의 폐기 사유를 입력해주세요.");
                reason.focus();
                return false;
            }
        }

        return confirm("일일 재고 마감을 저장하시겠습니까?");
    }

    document.querySelectorAll(".item-row").forEach(function(row) {
        updateRow(row);

        row.querySelector(".use-qty").addEventListener("input", function() {
            updateRow(row);
        });

        row.querySelector(".disposal-qty").addEventListener("input", function() {
            updateRow(row);
        });
    });
</script>

</body>
</html>