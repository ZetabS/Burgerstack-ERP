<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<c:url var="listUrl" value="/admin/stores" />
<c:url var="submitUrl" value="/admin/stores" />

<style>
  .phone-group {
    display: flex;
    align-items: center;
    gap: 6px;
  }

  .phone-group input {
    width: 120px;
    text-align: center;
  }

  .owner-search-group {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .owner-search-group input {
    max-width: 420px;
  }

  #ownerResultArea {
    min-height: 38px;
    width: 420px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 8px 10px;
    box-sizing: border-box;
    color: #6b7280;
    background: #fff;
  }

  .owner-item {
    cursor: pointer;
    padding: 7px 8px;
    border-radius: 6px;
  }

  .owner-item:hover {
    background: #f2f6ff;
  }
</style>

<t:layout>

  <c:if test="${not empty msg}">
    <script>
      alert("${msg}");
    </script>
  </c:if>

  <layout:Page title="점포 신규 등록" description="신규 점포 정보를 입력하고 대표 점주 계정을 연결합니다.">
    <jsp:attribute name="actions">
      <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>
    </jsp:attribute>

    <jsp:body>
      <form action="${submitUrl}"
            method="post"
            onsubmit="return validateStoreEnroll();">

        <layout:Section title="점포 등록" description="점포명, 연락처, 주소 정보를 입력합니다.">
          <layout:FieldRow label="점포명" inputId="storeName">
            <input type="text"
                   class="form-control"
                   id="storeName"
                   name="storeName"
                   maxlength="50"
                   value="${store.storeName}"
                   required />
          </layout:FieldRow>

          <layout:FieldRow label="연락처" inputId="phone1" help="3자리 - 4자리 - 4자리 숫자로 입력합니다.">
            <div class="phone-group">
              <input type="text"
                     class="form-control"
                     id="phone1"
                     name="phone1"
                     maxlength="3"
                     placeholder="010"
                     value="${phone1}"
                     required />

              <span>-</span>

              <input type="text"
                     class="form-control"
                     id="phone2"
                     name="phone2"
                     maxlength="4"
                     placeholder="1234"
                     value="${phone2}"
                     required />

              <span>-</span>

              <input type="text"
                     class="form-control"
                     id="phone3"
                     name="phone3"
                     maxlength="4"
                     placeholder="5678"
                     value="${phone3}"
                     required />
            </div>
          </layout:FieldRow>

          <layout:FieldRow label="주소" inputId="address">
            <input type="text"
                   class="form-control"
                   id="address"
                   name="address"
                   maxlength="200"
                   value="${store.address}"
                   required />
          </layout:FieldRow>

          <layout:FieldRow label="상세주소" inputId="detailAddress">
            <input type="text"
                   class="form-control"
                   id="detailAddress"
                   name="detailAddress"
                   maxlength="100"
                   placeholder="상세주소 입력"
                   value="${detailAddress}" />
          </layout:FieldRow>
        </layout:Section>

        <layout:Section title="점주 계정 연결" description="점주 아이디를 검색한 뒤 등록할 점포와 연결합니다.">
          <layout:FieldRow label="점주 아이디" inputId="searchOwnerId">
            <div class="owner-search-group">
              <input type="text"
                     class="form-control"
                     id="searchOwnerId"
                     placeholder="점주 아이디 입력" />

              <button type="button"
                      class="btn btn-primary"
                      onclick="searchOwner()">
                검색
              </button>
            </div>
          </layout:FieldRow>

          <layout:FieldRow label="검색 결과">
            <div id="ownerResultArea">
              <c:choose>
                <c:when test="${not empty store.ownerUserNo}">
                  기존 선택된 점주가 유지되었습니다.
                </c:when>
                <c:otherwise>
                  점주 아이디를 검색해주세요.
                </c:otherwise>
              </c:choose>
            </div>
          </layout:FieldRow>

          <layout:FieldRow label="선택된 점주" inputId="selectedOwner">
            <input type="hidden"
                   id="ownerUserNo"
                   name="ownerUserNo"
                   value="${store.ownerUserNo}" />

            <input type="text"
                   class="form-control"
                   id="selectedOwner"
                   readonly
                   value="${selectedOwnerText}"
                   placeholder="선택된 점주 없음" />
          </layout:FieldRow>
        </layout:Section>

        <input type="hidden" name="createStockYn" value="Y" />

        <common:Actions>
          <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>

          <button type="reset"
                  class="btn btn-outline-danger ml-2"
                  onclick="clearOwnerResult();">
            초기화
          </button>

          <button type="submit" class="btn btn-primary ml-2">
            등록
          </button>
        </common:Actions>

      </form>
    </jsp:body>
  </layout:Page>
</t:layout>

<script>
  const contextPath = "${pageContext.request.contextPath}";

  function handlePhoneInput(input, nextInputId, maxLength) {
    input.value = input.value.replace(/[^0-9]/g, "");

    if (input.value.length >= maxLength && nextInputId) {
      document.getElementById(nextInputId).focus();
    }
  }

  document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("phone1").addEventListener("input", function() {
      handlePhoneInput(this, "phone2", 3);
    });

    document.getElementById("phone2").addEventListener("input", function() {
      handlePhoneInput(this, "phone3", 4);
    });

    document.getElementById("phone3").addEventListener("input", function() {
      handlePhoneInput(this, null, 4);
    });
  });

  function searchOwner() {
    const keyword = document.getElementById("searchOwnerId").value.trim();
    const resultArea = document.getElementById("ownerResultArea");

    clearSelectedOwner();

    if (keyword === "") {
      alert("점주 아이디를 입력하세요.");
      resultArea.innerHTML = "점주 아이디를 검색해주세요.";
      return;
    }

    fetch(contextPath + "/admin/stores/owners/search?keyword=" + encodeURIComponent(keyword))
      .then(function(response) {
        return response.json();
      })
      .then(function(data) {
        if (!data.found) {
          resultArea.innerHTML = "검색 결과가 없습니다.";
          clearSelectedOwner();
          return;
        }

        resultArea.innerHTML =
          "<div class='owner-item' onclick=\"selectOwner('"
          + data.ownerUserNo + "', '"
          + data.ownerLoginId + "', '"
          + data.ownerName + "')\">"
          + data.ownerLoginId + " / "
          + data.ownerName
          + "</div>";
      })
      .catch(function() {
        resultArea.innerHTML = "검색 중 오류가 발생했습니다.";
        clearSelectedOwner();
      });
  }

  function selectOwner(ownerUserNo, ownerLoginId, ownerName) {
    document.getElementById("ownerUserNo").value = ownerUserNo;
    document.getElementById("selectedOwner").value =
      ownerLoginId + " / " + ownerName;

    alert(ownerName + " 점주 계정이 연결되었습니다.");
  }

  function clearSelectedOwner() {
    document.getElementById("ownerUserNo").value = "";
    document.getElementById("selectedOwner").value = "";
  }

  function clearOwnerResult() {
    setTimeout(function() {
      document.getElementById("ownerResultArea").innerHTML =
        "점주 아이디를 검색해주세요.";
      clearSelectedOwner();
    }, 0);
  }

  function validateStoreEnroll() {
    const ownerUserNo = document.getElementById("ownerUserNo").value;

    if (ownerUserNo === "") {
      alert("점주 계정을 검색 후 선택해주세요.");
      document.getElementById("searchOwnerId").focus();
      return false;
    }

    const phone1 = document.getElementById("phone1").value.trim();
    const phone2 = document.getElementById("phone2").value.trim();
    const phone3 = document.getElementById("phone3").value.trim();

    const phoneReg = /^[0-9]+$/;

    if (!phoneReg.test(phone1) || !phoneReg.test(phone2) || !phoneReg.test(phone3)) {
      alert("연락처는 숫자만 입력해주세요.");
      return false;
    }

    if (phone1.length !== 3 || phone2.length !== 4 || phone3.length !== 4) {
      alert("연락처는 3자리 - 4자리 - 4자리로 입력해주세요.");
      document.getElementById("phone1").focus();
      return false;
    }

    return confirm("점포를 등록하시겠습니까?");
  }
</script>