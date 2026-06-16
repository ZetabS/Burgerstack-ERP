<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<c:url var="listUrl" value="/admin/stores" />
<c:url var="submitUrl" value="/admin/stores" />

<style>
  .store-name-group {
    display: flex;
    align-items: center;
    gap: 8px;
    width: 100%;
    flex-wrap: wrap;
  }

  .store-name-group input {
    flex: 1 1 260px;
    min-width: 0;
  }

  .store-name-group button {
    flex-shrink: 0;
    white-space: nowrap;
  }

  .check-msg {
    margin-top: 6px;
    font-size: 13px;
  }

  .check-msg.ok {
    color: #15803d;
  }

  .check-msg.fail {
    color: #dc2626;
  }

  .phone-group {
    display: flex;
    align-items: center;
    gap: 6px;
    flex-wrap: wrap;
  }

  .phone-group select {
    width: 140px;
    min-width: 140px;
  }

  .phone-group input {
    width: 120px;
    text-align: center;
  }


  .owner-search-group {
    display: flex;
    align-items: center;
    gap: 8px;
    width: 100%;
    flex-wrap: wrap;
  }

  .owner-search-group input {
    flex: 1 1 260px;
    min-width: 0;
    max-width: 420px;
  }

  .owner-search-group button,
  .owner-search-group a {
    flex-shrink: 0;
    white-space: nowrap;
  }

  #ownerResultArea {
    min-height: 38px;
    width: 100%;
    max-width: 420px;
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
			  <div class="store-name-group">
			    <input type="text"
			           class="form-control"
			           id="storeName"
			           name="storeName"
			           maxlength="50"
			           value="${store.storeName}"
			           required />
			
			    <button type="button"
			            class="btn btn-outline-primary"
			            onclick="checkStoreName();">
			      중복확인
			    </button>
			  </div>
			
			  <div id="storeNameCheckMsg" class="check-msg">
			    점포명 중복확인을 해주세요.
			  </div>
			</layout:FieldRow>

          <layout:FieldRow label="연락처" inputId="phone1">
		  <div class="phone-group">
		    <select class="form-control"
		            id="phone1"
		            name="phone1"
		            required>
		      <option value="02"  ${phone1 eq '02' ? 'selected' : ''}>02</option>
		      <option value="031" ${phone1 eq '031' ? 'selected' : ''}>031</option>
		      <option value="032" ${phone1 eq '032' ? 'selected' : ''}>032</option>
		      <option value="033" ${phone1 eq '033' ? 'selected' : ''}>033</option>
		      <option value="041" ${phone1 eq '041' ? 'selected' : ''}>041</option>
		      <option value="042" ${phone1 eq '042' ? 'selected' : ''}>042</option>
		      <option value="043" ${phone1 eq '043' ? 'selected' : ''}>043</option>
		      <option value="044" ${phone1 eq '044' ? 'selected' : ''}>044</option>
		      <option value="051" ${phone1 eq '051' ? 'selected' : ''}>051</option>
		      <option value="052" ${phone1 eq '052' ? 'selected' : ''}>052</option>
		      <option value="053" ${phone1 eq '053' ? 'selected' : ''}>053</option>
		      <option value="054" ${phone1 eq '054' ? 'selected' : ''}>054</option>
		      <option value="055" ${phone1 eq '055' ? 'selected' : ''}>055</option>
		      <option value="061" ${phone1 eq '061' ? 'selected' : ''}>061</option>
		      <option value="062" ${phone1 eq '062' ? 'selected' : ''}>062</option>
		      <option value="063" ${phone1 eq '063' ? 'selected' : ''}>063</option>
		      <option value="064" ${phone1 eq '064' ? 'selected' : ''}>064</option>
		    </select>
		
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

  let storeNameChecked = false;
  let checkedStoreName = "";

  function handlePhoneInput(input, nextInputId, maxLength) {
    input.value = input.value.replace(/[^0-9]/g, "");

    if (input.value.length >= maxLength && nextInputId) {
      document.getElementById(nextInputId).focus();
    }
  }

  function setStoreNameMessage(message, isOk) {
    const msg = document.getElementById("storeNameCheckMsg");

    msg.innerText = message;
    msg.classList.remove("ok");
    msg.classList.remove("fail");

    if (isOk) {
      msg.classList.add("ok");
    } else {
      msg.classList.add("fail");
    }
  }

  document.addEventListener("DOMContentLoaded", function() {
    const storeNameInput = document.getElementById("storeName");

    storeNameInput.addEventListener("input", function() {
      storeNameChecked = false;
      checkedStoreName = "";

      if (this.value.trim() === "") {
        setStoreNameMessage("점포명을 입력해주세요.", false);
      } else {
        setStoreNameMessage("점포명 중복확인을 해주세요.", false);
      }
    });

    document.getElementById("phone1").addEventListener("change", function() {
    	  applyPhoneRule();
    	});

    	document.getElementById("phone2").addEventListener("input", function() {
    	  handlePhoneInput(this, "phone3", Number(this.maxLength));
    	});

    	document.getElementById("phone3").addEventListener("input", function() {
    	  handlePhoneInput(this, null, 4);
    	});

    	applyPhoneRule();
  });

  function checkStoreName() {
    const storeName = document.getElementById("storeName").value.trim();

    storeNameChecked = false;
    checkedStoreName = "";

    if (storeName === "") {
      setStoreNameMessage("점포명을 입력해주세요.", false);
      document.getElementById("storeName").focus();
      return;
    }

    fetch(contextPath + "/admin/stores/check-name?storeName=" + encodeURIComponent(storeName))
      .then(function(response) {
        return response.json();
      })
      .then(function(data) {
        setStoreNameMessage(data.message, data.available);

        if (data.available) {
          storeNameChecked = true;
          checkedStoreName = storeName;
        }
      })
      .catch(function() {
        setStoreNameMessage("점포명 중복확인 중 오류가 발생했습니다.", false);
      });
  }

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
        resultArea.innerHTML = "";

        if (!data.found) {
          resultArea.innerHTML = data.message || "검색 결과가 없습니다.";
          clearSelectedOwner();
          return;
        }

        if (data.available === false) {
          resultArea.innerHTML =
            "<span class='check-msg fail'>"
            + (data.message || "이미 점포에 연결된 점주입니다.")
            + "</span>";
          clearSelectedOwner();
          return;
        }

        const item = document.createElement("div");
        item.className = "owner-item";
        item.innerText = data.ownerLoginId + " / " + data.ownerName;

        item.addEventListener("click", function() {
          selectOwner(data.ownerUserNo, data.ownerLoginId, data.ownerName);
        });

        resultArea.appendChild(item);
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

      storeNameChecked = false;
      checkedStoreName = "";
      setStoreNameMessage("점포명 중복확인을 해주세요.", false);
    }, 0);
  }

  function validateStoreEnroll() {
	  const storeName = document.getElementById("storeName").value.trim();

	  if (storeName === "") {
	    alert("점포명을 입력해주세요.");
	    document.getElementById("storeName").focus();
	    return false;
	  }

	  if (!storeNameChecked || checkedStoreName !== storeName) {
	    alert("점포명 중복확인을 해주세요.");
	    document.getElementById("storeName").focus();
	    return false;
	  }

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

	  if (!phoneReg.test(phone1)
	      || !phoneReg.test(phone2)
	      || !phoneReg.test(phone3)) {

	    alert("연락처는 숫자만 입력해주세요.");
	    document.getElementById("phone2").focus();
	    return false;
	  }

	  const phone2RequiredLength = phone1 === "02" ? 4 : 3;

	  if (phone1 === "02") {
	    if (phone2.length !== 4 || phone3.length !== 4) {
	      alert("서울(02)은 02-1234-5678 형식으로 입력해주세요.");
	      document.getElementById("phone2").focus();
	      return false;
	    }
	  } else {
	    if (phone1.length !== 3 || phone2.length !== 3 || phone3.length !== 4) {
	      alert("서울 외 지역은 031-123-4567 형식으로 입력해주세요.");
	      document.getElementById("phone2").focus();
	      return false;
	    }
	  }

	  return confirm("점포를 등록하시겠습니까?");
	}
  
  function applyPhoneRule() {
	  const phone1 = document.getElementById("phone1").value;
	  const phone2 = document.getElementById("phone2");

	  if (phone1 === "02") {
	    phone2.maxLength = 4;
	    phone2.placeholder = "1234";
	  } else {
	    phone2.maxLength = 3;
	    phone2.placeholder = "123";

	    if (phone2.value.length > 3) {
	      phone2.value = phone2.value.substring(0, 3);
	    }
	  }
	}
  
  document.getElementById("phone1").addEventListener("change", function() {
	  applyPhoneRule();
	});

	applyPhoneRule();
</script>