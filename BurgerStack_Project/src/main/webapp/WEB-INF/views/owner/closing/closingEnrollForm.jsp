<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

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
        margin-bottom: 25px;
        padding-left: 12px;
        border-left: 5px solid #19c765;
        font-size: 22px;
        font-weight: bold;
    }

    .date-area {
        margin-bottom: 20px;
    }

    .date-area input {
        height: 36px;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 0 10px;
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
    }

    textarea {
        width: 100%;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 8px;
    }

    .memo-area {
        margin-top: 20px;
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

    .usage-qty {
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
        resize: vertical;
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

    <form action="${pageContext.request.contextPath}/owner/closings"
          method="post">

        <div class="date-area">
            <strong>영업일</strong>
            <input type="date"
                   name="businessDate"
                   required>
        </div>

        <table>

            <thead>
                <tr>
                    <th>자재명</th>
                    <th>전산재고</th>
                    <th>사용수량</th>
                    <th>폐기수량</th>
                    <th>현재(남은) 수량</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="inv" items="${inventoryList}">

                    <tr class="item-row">

                        <td>
                            ${inv.materialName}

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
                            <span class="use-qty usage-qty">0</span>

                            <input type="hidden"
                                   name="physicalQuantity"
                                   class="use-qty-hidden"
                                   value="0">
                        </td>

                        <td>
                            <input type="number"
                                   name="disposalQuantity"
                                   class="disposal-qty"
                                   value="0"
                                   min="0">
                        </td>

                        <td>
                            <input type="number"
                                   class="remain-qty"
                                   value="${inv.currentQuantity}"
                                   min="0"
                                   required>
                        </td>

                    </tr>

                    <tr class="reason-row" style="display:none;">
                        <td colspan="5" class="reason-cell">
                            <strong>폐기사유</strong>
                            <textarea name="closingItemMemo"
                                      class="disposal-reason"
                                      placeholder="폐기사유를 입력하세요"></textarea>
                        </td>
                    </tr>

                </c:forEach>

            </tbody>

        </table>

        <div class="memo-area">

            <strong>마감 메모</strong>

            <br><br>

            <textarea name="closingMemo"
                      rows="5"
                      required></textarea>

        </div>

        <button type="submit"
                class="submit-btn">
            마감하기
        </button>

    </form>

    <script>
        function updateRow(row) {
            const systemQty =
                Number(row.querySelector(".system-qty").value || 0);

            const remainQty =
                Number(row.querySelector(".remain-qty").value || 0);

            const disposalQty =
                Number(row.querySelector(".disposal-qty").value || 0);

            let useQty =
                systemQty - remainQty - disposalQty;

            if (useQty < 0) {
                useQty = 0;
            }

            row.querySelector(".use-qty").innerText = useQty;
            row.querySelector(".use-qty-hidden").value = useQty;

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

        document.querySelectorAll(".item-row").forEach(function(row) {
            updateRow(row);

            row.querySelector(".remain-qty").addEventListener("input", function() {
                updateRow(row);
            });

            row.querySelector(".disposal-qty").addEventListener("input", function() {
                updateRow(row);
            });
        });
    </script>

</section>

</t:layout>

</body>
</html>