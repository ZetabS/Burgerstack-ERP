<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<c:url var="listUrl" value="/admin/stores" />
<c:url var="submitUrl" value="/admin/stores/${store.storeId}/update" />

<t:layout>

  <c:if test="${not empty msg}">
    <script>
      alert("${msg}");
    </script>
  </c:if>

  <layout:Page title="점포 상세 정보 조회" description="점포 정보를 확인하고 수정할 수 있습니다.">
    <jsp:attribute name="actions">
      <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>
    </jsp:attribute>

    <jsp:body>

      <form action="${submitUrl}"
            method="post"
            onsubmit="return checkStoreUpdate();">

        <input type="hidden" name="storeId" value="${store.storeId}" />
        <input type="hidden" id="originalStatus" value="${store.status}" />

        <layout:Section title="기본 정보" description="점포의 기본 등록 정보를 확인합니다.">

          <layout:FieldRow label="점포 코드">
            <c:choose>
              <c:when test="${not empty store.storeCode}">
                ${store.storeCode}
              </c:when>
              <c:otherwise>
                S${store.storeId}
              </c:otherwise>
            </c:choose>
          </layout:FieldRow>

          <layout:FieldRow label="대표 점주">
            <c:choose>
              <c:when test="${not empty store.ownerName}">
                ${store.ownerName}
              </c:when>
              <c:otherwise>
                <span class="text-muted">-</span>
              </c:otherwise>
            </c:choose>
          </layout:FieldRow>

          <layout:FieldRow label="상태">
            <c:choose>
              <c:when test="${store.status eq 'OPEN'}">
                <span class="badge badge-success">영업중</span>
              </c:when>
              <c:otherwise>
                <span class="badge badge-danger">폐점</span>
              </c:otherwise>
            </c:choose>
          </layout:FieldRow>

          <layout:FieldRow label="등록일">
            <c:choose>
              <c:when test="${not empty store.createdAt}">
                ${store.createdAt.toString().replace('T', ' ')}
              </c:when>
              <c:otherwise>
                <span class="text-muted">-</span>
              </c:otherwise>
            </c:choose>
          </layout:FieldRow>

        </layout:Section>

        <layout:Section title="점포 수정" description="점포명, 연락처, 주소, 운영 상태를 수정합니다.">

          <layout:FieldRow label="점포명" inputId="storeName">
            <input type="text"
                   class="form-control"
                   id="storeName"
                   name="storeName"
                   value="${store.storeName}"
                   required />
          </layout:FieldRow>

          <layout:FieldRow label="점포 연락처" inputId="phone" help="예: 010-1234-5678">
            <input type="text"
                   class="form-control"
                   id="phone"
                   name="phone"
                   value="${store.phone}"
                   placeholder="예: 010-1234-5678"
                   required />
          </layout:FieldRow>

          <layout:FieldRow label="주소" inputId="address">
            <input type="text"
                   class="form-control"
                   id="address"
                   name="address"
                   value="${store.address}" />
          </layout:FieldRow>

          <layout:FieldRow label="상태" inputId="status">
            <select name="status"
                    id="status"
                    class="form-control">
              <option value="OPEN" ${store.status eq 'OPEN' ? 'selected' : ''}>
                영업중
              </option>

              <option value="CLOSED" ${store.status eq 'CLOSED' ? 'selected' : ''}>
                폐점
              </option>
            </select>
          </layout:FieldRow>

          <layout:FieldRow label="대표 점주">
            <input type="text"
                   class="form-control"
                   value="${empty store.ownerName ? '-' : store.ownerName}"
                   readonly />
          </layout:FieldRow>

        </layout:Section>

        <common:Actions>
          <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>

          <button type="submit" class="btn btn-primary ml-2">
            수정
          </button>
        </common:Actions>

      </form>

    </jsp:body>
  </layout:Page>
</t:layout>

<script>
  function checkStoreUpdate() {
    const phone = document.getElementById("phone").value.trim();
    const phoneReg = /^\d{3}-\d{4}-\d{4}$/;

    if (!phoneReg.test(phone)) {
      alert("연락처는 010-1234-5678 형식으로 입력해주세요.");
      document.getElementById("phone").focus();
      return false;
    }

    const originalStatus = document.getElementById("originalStatus").value;
    const status = document.getElementById("status").value;

    if (originalStatus !== "CLOSED" && status === "CLOSED") {
      const input = prompt("폐점 처리하려면 '폐점처리'를 입력하세요.");

      if (input !== "폐점처리") {
        alert("입력값이 올바르지 않아 폐점 처리가 취소되었습니다.");
        return false;
      }

      return confirm("정말 해당 점포를 폐점 처리하시겠습니까?");
    }

    return confirm("점포 정보를 수정하시겠습니까?");
  }
</script>