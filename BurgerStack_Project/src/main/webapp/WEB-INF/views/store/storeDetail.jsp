<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>

<c:url var="listUrl" value="/admin/stores" />
<c:url var="submitUrl" value="/admin/stores/${store.storeId}/update" />

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
</style>

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
            <input type="hidden"
                   id="originalStoreName"
                   value="${store.storeName}" />

            <div class="store-name-group">
              <input type="text"
                     class="form-control"
                     id="storeName"
                     name="storeName"
                     value="${store.storeName}"
                     required />

              <button type="button"
                      class="btn btn-outline-primary"
                      onclick="checkStoreNameForUpdate();">
                중복확인
              </button>
            </div>

            <div id="storeNameCheckMsg" class="check-msg ok">
              기존 점포명입니다.
            </div>
          </layout:FieldRow>

          <layout:FieldRow label="점포 연락처"
                           inputId="phone1">
            <input type="hidden"
                   id="phone"
                   name="phone"
                   value="${store.phone}" />

            <div class="phone-group">
              <select class="form-control"
                      id="phone1"
                      required>
                <option value="02">02</option>
                <option value="031">031</option>
                <option value="032">032</option>
                <option value="033">033</option>
                <option value="041">041</option>
                <option value="042">042</option>
                <option value="043">043</option>
                <option value="044">044</option>
                <option value="051">051</option>
                <option value="052">052</option>
                <option value="053">053</option>
                <option value="054">054</option>
                <option value="055">055</option>
                <option value="061">061</option>
                <option value="062">062</option>
                <option value="063">063</option>
                <option value="064">064</option>
              </select>

              <span>-</span>

              <input type="text"
                     class="form-control"
                     id="phone2"
                     maxlength="4"
                     placeholder="1234"
                     required />

              <span>-</span>

              <input type="text"
                     class="form-control"
                     id="phone3"
                     maxlength="4"
                     placeholder="5678"
                     required />
            </div>
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
  const contextPath = "${pageContext.request.contextPath}";
  const storeId = "${store.storeId}";

  let storeNameChecked = true;
  let checkedStoreName = "";

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

  function handlePhoneInput(input, nextInputId, maxLength) {
    input.value = input.value.replace(/[^0-9]/g, "");

    if (input.value.length >= maxLength && nextInputId) {
      document.getElementById(nextInputId).focus();
    }
  }

  document.addEventListener("DOMContentLoaded", function() {
    const originalStoreName =
      document.getElementById("originalStoreName").value.trim();

    const storeNameInput =
      document.getElementById("storeName");

    checkedStoreName = originalStoreName;

    storeNameInput.addEventListener("input", function() {
      const currentName = this.value.trim();

      if (currentName === originalStoreName) {
        storeNameChecked = true;
        checkedStoreName = currentName;
        setStoreNameMessage("기존 점포명입니다.", true);
      } else {
        storeNameChecked = false;
        checkedStoreName = "";
        setStoreNameMessage("점포명 중복확인을 해주세요.", false);
      }
    });

    const originalPhone = document.getElementById("phone").value;
    const phone1Select = document.getElementById("phone1");

    if (originalPhone && originalPhone.indexOf("-") > -1) {
      const phoneParts = originalPhone.split("-");

      if (phoneParts.length === 3) {
        const prefix = phoneParts[0];

        let exists = false;

        for (let i = 0; i < phone1Select.options.length; i++) {
          if (phone1Select.options[i].value === prefix) {
            exists = true;
            break;
          }
        }

        if (!exists) {
          const option = document.createElement("option");
          option.value = prefix;
          option.text = prefix + " (기존)";
          phone1Select.insertBefore(option, phone1Select.firstChild);
        }

        phone1Select.value = prefix;
        document.getElementById("phone2").value = phoneParts[1];
        document.getElementById("phone3").value = phoneParts[2];
      }
    }

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

  function checkStoreNameForUpdate() {
    const storeName =
      document.getElementById("storeName").value.trim();

    const originalStoreName =
      document.getElementById("originalStoreName").value.trim();

    storeNameChecked = false;
    checkedStoreName = "";

    if (storeName === "") {
      setStoreNameMessage("점포명을 입력해주세요.", false);
      document.getElementById("storeName").focus();
      return;
    }

    if (storeName === originalStoreName) {
      storeNameChecked = true;
      checkedStoreName = storeName;
      setStoreNameMessage("기존 점포명입니다.", true);
      return;
    }

    fetch(
      contextPath
      + "/admin/stores/check-name?storeId="
      + encodeURIComponent(storeId)
      + "&storeName="
      + encodeURIComponent(storeName)
    )
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

  function checkStoreUpdate() {
	  const storeName =
	    document.getElementById("storeName").value.trim();

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

	  document.getElementById("phone").value =
	    phone1 + "-" + phone2 + "-" + phone3;

	  const originalStatus =
	    document.getElementById("originalStatus").value;

	  const status =
	    document.getElementById("status").value;

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
  
</script>