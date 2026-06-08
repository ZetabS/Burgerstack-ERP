<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <title>재고 조정</title>
    <style></style>
  </head>
  <body>
    <t:menubarHO>
      <div class="container py-4">
        <h2 class="mb-4">재고 변동 이력</h2>

        <form action="/burgerstack/admin/inventories/${detail.inventoryId}" method="post">
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

          <div class="d-flex justify-content-end">
            <a href="/burgerstack/admin/inventories" class="btn btn-secondary mr-2">목록</a>
            <button type="submit" class="btn btn-primary">저장</button>
          </div>
        </form>
      </div>
    </t:menubarHO>
  </body>
</html>
