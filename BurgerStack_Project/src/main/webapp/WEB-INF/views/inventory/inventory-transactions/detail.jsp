<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/ui" %>
<c:set var="isAdmin" value="${sessionScope.loginUser.admin}" />
<c:set var="role" value="${isAdmin ? 'admin' : 'owner'}" />
<c:url var="backToList" value="/${role}/inventory-transactions" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>재고 변동 상세</title>
    <style></style>
  </head>
  <body>
    <t:layout>
      <div class="outer container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2 class="mb-0">재고 변동 상세</h2>

          <a href="${backToList}" class="back-to-list-btn btn btn-secondary">목록으로</a>
        </div>

        <div class="card mb-4">
          <div class="card-header">기본 정보</div>

          <div class="card-body">
            <div class="row mb-3">
              <div class="col-sm-3 font-weight-bold">변동 번호</div>

              <div class="col-sm-9">${detail.inventoryTransactionId}</div>
            </div>

            <div class="row mb-3">
              <div class="col-sm-3 font-weight-bold">변동 유형</div>

              <div class="col-sm-9">${detail.transactionType}</div>
            </div>

            <c:if test="${isAdmin}">
              <div class="row mb-3">
                <div class="col-sm-3 font-weight-bold">점포명</div>
                <div class="col-sm-9">${detail.storeName}</div>
              </div>
            </c:if>

            <div class="row mb-3">
              <div class="col-sm-3 font-weight-bold">처리자</div>

              <div class="col-sm-9">${detail.createdByName}</div>
            </div>

            <div class="row mb-3">
              <div class="col-sm-3 font-weight-bold">처리 일시</div>

              <div class="col-sm-9">${detail.createdAt}</div>
            </div>

            <div class="row mb-3">
              <div class="col-sm-3 font-weight-bold">사유</div>

              <div class="col-sm-9">
                <c:out value="${detail.reason}" />
              </div>
            </div>

            <div class="row">
              <div class="col-sm-3 font-weight-bold">비고</div>

              <div class="col-sm-9">
                <c:choose>
                  <c:when test="${empty detail.transactionMemo}">
                    <span class="text-muted">-</span>
                  </c:when>

                  <c:otherwise>
                    <c:out value="${detail.transactionMemo}" />
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </div>

        <div class="card mb-4">
          <div class="card-header">변동 품목</div>

          <div class="card-body p-0">
            <ui:DataTable>
              <jsp:attribute name="thead">
                <tr>
                  <th>자재명</th>
                  <th class="text-right">변동 전 수량</th>
                  <th>변동 수량</th>
                  <th>변동 후 수량</th>
                </tr>
              </jsp:attribute>
              <jsp:attribute name="tbody">
                <c:forEach var="item" items="${detail.list}">
                  <ui:TableRow>
                    <ui:TextCell value="${item.materialName}" />
                    <ui:NumberCell value="${item.beforeQuantity}" />
                    <ui:DeltaCell value="${item.changedQuantity}" />
                    <ui:NumberCell value="${item.afterQuantity}" />
                  </ui:TableRow>
                </c:forEach>
              </jsp:attribute>
            </ui:DataTable>
          </div>
        </div>

        <div class="text-right">
          <a href="${backToList}" class="back-to-list-btn btn btn-secondary">목록으로</a>
        </div>
      </div>
    </t:layout>
    <script>
      $(".back-to-list-btn").on("click", (e) => {
        const listUrl = sessionStorage.getItem("inventoryTransactionListUrl");
        if (listUrl) {
          e.preventDefault();
          window.location.href = listUrl;
        }
      });
    </script>
  </body>
</html>
