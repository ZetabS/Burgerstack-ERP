<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>재고 조정</title>
    <style></style>
  </head>
  <body>
    <t:layout>
      <div class="outer container py-4">
        <h2 class="mb-4">재고 조정</h2>

        <form action="/burgerstack/admin/inventories/${detail.inventoryId}/adjust" method="post">
          <div class="card mb-4">
            <div class="card-header">재고 정보</div>

            <div class="card-body">
              <div class="row mb-3">
                <div class="col-sm-3 fw-bold">점포명</div>
                <div class="col-sm-9">${detail.storeName}</div>
              </div>

              <div class="row mb-3">
                <div class="col-sm-3 fw-bold">자재명</div>
                <div class="col-sm-9">${detail.materialName}</div>
              </div>

              <div class="row mb-3">
                <div class="col-sm-3 fw-bold">현재 수량</div>
                <div class="col-sm-9">${detail.currentQuantity}</div>
              </div>

              <div class="row">
                <div class="col-sm-3 fw-bold">안전재고 수량</div>
                <div class="col-sm-9">${detail.safetyQuantity}</div>
              </div>
            </div>
          </div>

          <div class="card mb-4">
            <div class="card-header">조정 입력</div>

            <div class="card-body">
              <div class="mb-3">
                <label for="afterQuantity" class="form-label">조정 후 수량</label>
                <input type="number" class="form-control" id="afterQuantity" name="afterQuantity" value="${detail.currentQuantity}" min="0" required />
              </div>

              <div class="mb-3">
                <label for="reason" class="form-label">사유</label>
                <input type="text" class="form-control" id="reason" name="reason" placeholder="예: 실사 오차, 폐기, 입고 누락" required />
              </div>

              <div class="mb-3">
                <label for="transactionMemo" class="form-label">비고</label>
                <textarea class="form-control" id="transactionMemo" name="transactionMemo" placeholder="추가 설명이 필요한 경우 입력하세요." rows="5"></textarea>
              </div>
            </div>
          </div>

          <div class="d-flex justify-content-end">
            <a href="/burgerstack/admin/inventories" class="btn btn-secondary mr-2 back-to-list-btn">목록으로</a>
            <button type="submit" class="btn btn-primary">조정</button>
          </div>
        </form>
      </div>
    </t:layout>
    <script>
      $(".back-to-list-btn").on("click", (e) => {
        const listUrl = sessionStorage.getItem("inventoryListUrl");
        if (listUrl) {
          e.preventDefault();
          window.location.href = listUrl;
        }
      });
    </script>
  </body>
</html>
