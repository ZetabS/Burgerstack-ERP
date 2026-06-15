<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<c:url var="listUrl" value="/owner/receipts/planned" />
<c:url var="submitUrl" value="/owner/receipts/${purchaseId}/receipt" />

<style>
  .receipt-table input[type="number"] {
    width: 80px;
    text-align: center;
  }

  .diff-qty {
    background: #f3f4f6;
    border: 1px solid #d1d5db;
    text-align: center;
  }

  .row-diff-amount {
    font-weight: 600;
  }

  .total-price {
    font-weight: 700;
    color: #ff6b00;
  }

  .modal-wrap {
    display: none;
    position: fixed;
    z-index: 9999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.45);
  }

  .modal-box {
    width: 650px;
    background: white;
    border-radius: 12px;
    padding: 25px 30px;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    box-shadow: 0 10px 30px rgba(0,0,0,0.25);
  }

  .modal-title {
    font-size: 22px;
    font-weight: 700;
    margin-bottom: 15px;
  }

  .modal-summary-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 15px;
    font-size: 14px;
  }

  .modal-summary-table th,
  .modal-summary-table td {
    border-bottom: 1px solid #e5e7eb;
    padding: 9px;
    text-align: center;
  }

  .modal-summary-table th {
    background: #f9fafb;
  }

  .modal-total {
    text-align: right;
    font-weight: 700;
    color: #ff6b00;
    margin-bottom: 15px;
  }

  .memo-area {
    margin-top: 15px;
  }

  .memo-area label {
    display: block;
    font-weight: 700;
    margin-bottom: 8px;
  }

  .memo-area textarea {
    width: 100%;
    height: 90px;
    resize: none;
    padding: 10px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    box-sizing: border-box;
  }

  .modal-btn-area {
    text-align: right;
    margin-top: 20px;
  }
</style>

<t:layout>
  <layout:Page title="입고 처리" description="승인된 발주 품목을 검수하고 실제 입고 수량을 등록합니다.">

    <jsp:attribute name="actions">
      <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>
    </jsp:attribute>

    <jsp:body>

      <form action="${submitUrl}" method="post">

        <layout:Section title="입고 기본 정보">

          <layout:FieldRow label="발주번호">
            ${purchaseId}
          </layout:FieldRow>

          <layout:FieldRow label="상태">
            <c:choose>
              <c:when test="${purchaseStatus eq 'APPROVED'}">
                <span class="badge badge-success">승인</span>
              </c:when>

              <c:when test="${purchaseStatus eq 'PARTIALLY_APPROVED'}">
                <span class="badge badge-warning">부분 승인</span>
              </c:when>

              <c:otherwise>
                <span class="badge badge-secondary">
                  ${purchaseStatus}
                </span>
              </c:otherwise>
            </c:choose>
          </layout:FieldRow>

        </layout:Section>

        <layout:TableSection title="입고 검수 품목" description="실입고 수량을 입력하면 차이 수량과 차액이 자동 계산됩니다.">

          <table:Table isEmpty="${empty itemList}" emptyMessage="입고 처리할 품목이 없습니다.">

            <jsp:attribute name="thead">
              <tr>
                <th>상품코드</th>
                <th class="text-center">상품유형</th>
                <th>상품명</th>
                <th class="text-right">발주수량</th>
                <th class="text-right">승인수량</th>

                <c:if test="${purchaseStatus eq 'PARTIALLY_APPROVED'}">
                  <th class="text-right">반려수량</th>
                  <th>반려사유</th>
                </c:if>

                <th class="text-right">실입고 수량</th>
                <th class="text-right">차이 수량</th>
                <th>사유</th>
                <th class="text-right">단가</th>
                <th class="text-right">차액</th>
              </tr>
            </jsp:attribute>

            <jsp:attribute name="tbody">

              <c:forEach var="item" items="${itemList}" varStatus="status">
                <tr class="receipt-row">

                  <td>${item.materialCode}</td>

                  <td class="text-center">
                    <c:choose>
                      <c:when test="${item.materialType eq 'AF'}">상온</c:when>
                      <c:when test="${item.materialType eq 'RF'}">냉장</c:when>
                      <c:when test="${item.materialType eq 'FF'}">냉동</c:when>
                      <c:when test="${item.materialType eq 'PK'}">포장재</c:when>
                      <c:when test="${item.materialType eq 'KW'}">주방용품</c:when>
                      <c:otherwise>${item.materialType}</c:otherwise>
                    </c:choose>
                  </td>

                  <td class="material-name">
                    ${item.materialName}
                  </td>

                  <td class="text-right">
                    ${item.requestQuantity}
                  </td>

                  <td class="text-right approved-qty-text">
                    ${item.approvedQuantity}
                  </td>

                  <c:if test="${purchaseStatus eq 'PARTIALLY_APPROVED'}">
                    <td class="text-right">
                      ${item.rejectedQuantity}
                    </td>

                    <td>
                      ${item.rejectReason}
                    </td>
                  </c:if>

                  <td class="text-right">
                    <input type="hidden"
                           name="items[${status.index}].purchaseOrderItemId"
                           value="${item.purchaseOrderItemId}" />

                    <input type="number"
					       class="form-control form-control-sm received-qty"
					       name="items[${status.index}].receivedQuantity"
					       value="${item.approvedQuantity}"
					       min="0"
					       max="1000"
					       step="1"
					       data-approved="${item.approvedQuantity}"
					       data-max="1000"
					       data-price="${item.supplyPrice}" />
                  </td>

                  <td class="text-right">
                    <input type="number"
                           class="form-control form-control-sm diff-qty"
                           name="items[${status.index}].defectQuantity"
                           value="0"
                           readonly />
                  </td>

                  <td>
                    <select name="items[${status.index}].receiptItemMemo"
                            class="form-control form-control-sm diff-reason"
                            disabled>
                      <option value="">선택</option>
                      <option value="수량 부족">수량 부족</option>
                      <option value="초과 입고">초과 입고</option>
                      <option value="파손">파손</option>
                      <option value="변질">변질</option>
                      <option value="기타">기타</option>
                    </select>
                  </td>

                  <td class="text-right">
                    <fmt:formatNumber value="${item.supplyPrice}" pattern="#,###" />원
                  </td>

                  <td class="text-right row-diff-amount">
                    0원
                  </td>

                </tr>
              </c:forEach>

              <c:if test="${not empty itemList}">
                <tr class="font-weight-bold">
                  <th>총계</th>
                  <td class="text-right"
                      colspan="${purchaseStatus eq 'PARTIALLY_APPROVED' ? 11 : 9}">
                    <span id="totalDiffAmount" class="total-price">0원</span>
                  </td>
                </tr>
              </c:if>

            </jsp:attribute>

          </table:Table>

        </layout:TableSection>

        <common:Actions>
          <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>

          <button type="reset"
                  id="resetBtn"
                  class="btn btn-secondary ml-2">
            초기화
          </button>

          <button type="button"
                  class="btn btn-primary ml-2"
                  id="openConfirmModalBtn">
            저장
          </button>
        </common:Actions>

        <!-- 저장 확인 모달 -->
        <div class="modal-wrap" id="confirmModal">
          <div class="modal-box">

            <div class="modal-title">
              입고 처리 확인
            </div>

            <table class="modal-summary-table">
              <thead>
                <tr>
                  <th>상품명</th>
                  <th>승인수량</th>
                  <th>실입고 수량</th>
                  <th>차이 수량</th>
                  <th>사유</th>
                  <th>차액</th>
                </tr>
              </thead>

              <tbody id="modalSummaryBody">
              </tbody>
            </table>

            <div class="modal-total">
              총계 : <span id="modalTotalAmount">0원</span>
            </div>

            <div class="memo-area">
              <label for="receiptMemo">비고</label>
              <textarea id="receiptMemo"
                        name="receiptMemo"
                        placeholder="입고 처리 비고를 입력하세요."></textarea>
            </div>

            <div class="modal-btn-area">
              <button type="button"
                      class="btn btn-secondary"
                      onclick="closeConfirmModal()">
                취소
              </button>

              <button type="button"
                      class="btn btn-primary ml-2"
                      onclick="submitReceiptForm()">
                확인 후 저장
              </button>
            </div>

          </div>
        </div>

      </form>

    </jsp:body>
  </layout:Page>
</t:layout>

<script>
  function formatAmount(amount) {
    return Number(amount).toLocaleString() + "원";
  }

  function calculateAll() {
    let total = 0;

    document.querySelectorAll(".receipt-row").forEach(function(row) {
      let receivedInput = row.querySelector(".received-qty");
      let diffInput = row.querySelector(".diff-qty");
      let reasonSelect = row.querySelector(".diff-reason");
      let amountCell = row.querySelector(".row-diff-amount");

      let receivedQty = Number(receivedInput.value || 0);
      let approvedQty = Number(receivedInput.dataset.approved || 0);
      let maxQty = Number(receivedInput.dataset.max || 1000);
      let price = Number(receivedInput.dataset.price || 0);

      if (receivedQty < 0) {
        receivedQty = 0;
        receivedInput.value = 0;
      }

      if (receivedQty > maxQty) {
        receivedQty = maxQty;
        receivedInput.value = maxQty;
      }

      let diffQty = receivedQty - approvedQty;
      let diffAmount = diffQty * price;

      diffInput.value = diffQty;
      amountCell.innerText = formatAmount(diffAmount);

      if (diffQty !== 0) {
        reasonSelect.disabled = false;
        reasonSelect.required = true;
      } else {
        reasonSelect.value = "";
        reasonSelect.disabled = true;
        reasonSelect.required = false;
      }

      total += diffAmount;
    });

    let totalDiffAmount = document.getElementById("totalDiffAmount");

    if (totalDiffAmount) {
      totalDiffAmount.innerText = formatAmount(total);
    }
  }

  function validateReason() {
    let valid = true;

    document.querySelectorAll(".receipt-row").forEach(function(row) {
      let diffInput = row.querySelector(".diff-qty");
      let reasonSelect = row.querySelector(".diff-reason");
      let materialName = row.querySelector(".material-name").innerText;

      let diffQty = Number(diffInput.value || 0);

      if (diffQty !== 0 && !reasonSelect.value) {
        alert(materialName + "의 사유를 선택해야 합니다.");
        reasonSelect.focus();
        valid = false;
      }
    });

    return valid;
  }

  function openConfirmModal() {
    calculateAll();

    if (!validateReason()) {
      return;
    }

    let modalBody = document.getElementById("modalSummaryBody");
    let modalTotalAmount = document.getElementById("modalTotalAmount");

    modalBody.innerHTML = "";

    let total = 0;
    let hasDiff = false;

    document.querySelectorAll(".receipt-row").forEach(function(row) {
      let materialName = row.querySelector(".material-name").innerText;
      let receivedInput = row.querySelector(".received-qty");
      let diffInput = row.querySelector(".diff-qty");
      let reasonSelect = row.querySelector(".diff-reason");

      let approvedQty = Number(receivedInput.dataset.approved || 0);
      let receivedQty = Number(receivedInput.value || 0);
      let price = Number(receivedInput.dataset.price || 0);
      let diffQty = Number(diffInput.value || 0);
      let diffAmount = diffQty * price;
      let reason = reasonSelect.value;

      if (diffQty !== 0) {
        hasDiff = true;
        total += diffAmount;

        let tr = document.createElement("tr");

        tr.innerHTML =
          "<td>" + materialName + "</td>" +
          "<td>" + approvedQty + "</td>" +
          "<td>" + receivedQty + "</td>" +
          "<td>" + diffQty + "</td>" +
          "<td>" + reason + "</td>" +
          "<td>" + formatAmount(diffAmount) + "</td>";

        modalBody.appendChild(tr);
      }
    });

    if (!hasDiff) {
      let tr = document.createElement("tr");

      tr.innerHTML =
        "<td colspan='6'>차이 수량이 있는 품목이 없습니다.</td>";

      modalBody.appendChild(tr);
    }

    modalTotalAmount.innerText = formatAmount(total);

    document.getElementById("confirmModal").style.display = "block";
  }

  function closeConfirmModal() {
    document.getElementById("confirmModal").style.display = "none";
  }

  function submitReceiptForm() {
    calculateAll();

    if (!validateReason()) {
      return;
    }

    document.getElementById("receiptForm").submit();
  }

  document.addEventListener("input", function(e) {
    if (e.target.classList.contains("received-qty")) {
      calculateAll();
    }
  });

  document.addEventListener("DOMContentLoaded", function() {
    calculateAll();

    document.getElementById("openConfirmModalBtn").addEventListener("click", function() {
      openConfirmModal();
    });

    document.getElementById("resetBtn").addEventListener("click", function() {
      setTimeout(function() {
        calculateAll();
      }, 0);
    });

    document.getElementById("receiptForm").addEventListener("submit", function(e) {
      e.preventDefault();
      openConfirmModal();
    });
  });
</script>