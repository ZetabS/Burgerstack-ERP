<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>

<%--
  폼 페이지 패턴 예제입니다.

  기본 구조:
  1. 폼 전용 Page 컴포넌트는 따로 두지 않습니다.
     <layout:Page>의 본문에 업무별 <form>을 직접 작성합니다.
  2. 입력 그룹은 <layout:Section>으로 나눕니다.
  3. 각 입력은 <layout:FieldRow>로 라벨/입력 정렬을 통일합니다.
  4. 저장/취소 버튼은 <common:Actions>에 둡니다.

  주의:
  - <layout:Page>에서 actions 슬롯을 사용하므로 <jsp:body>를 반드시 명시합니다.
  - select option은 과하게 추상화하지 않고 일반 HTML로 작성합니다.
  - 도메인 코드의 표시만 display 태그를 사용합니다.

  필요한 taglib 지시어:
  - layout 컴포넌트: <%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
  - common 컴포넌트: <%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
  - display 컴포넌트: <%@ taglib prefix="display" tagdir="/WEB-INF/tags/display" %>
--%>

<c:url var="listUrl" value="/admin/${user.userId}" />
<c:url var="submitUrl" value="/admin/users/${user.userId}" />

<t:layout>
  <layout:Page title="점주 등록" description="">
  
	<jsp:attribute name="actions">
	  <button type="button" class="btn btn-outline-secondary" onclick="resetPassword()">비밀번호 재설정</button>
	</jsp:attribute>
    <jsp:body>
      <%--
        form 태그는 컴포넌트가 숨기지 않습니다.
        action, method, hidden input, CSRF 같은 업무별 요구사항을 화면에서 명확히 드러내기 위함입니다.
      --%>
     <form action="${submitUrl}" method="post">
		  <input type="hidden" name="userNo" value="${user.userNo}" />
		  
		  <%-- [이 부분 추가] 기존 상태 값을 그대로 폼에 담아 보냅니다 --%>
		  <input type="hidden" name="status" value="${user.status}" /> 
		
		  <layout:Section title="문의사항을 작성해주세요." description="">
	      <layout:FieldRow label="아이디" inputId="safetyQuantity" help="아이디를 입력하시오.">
	        <%-- [수정] type="userId"를 type="text"로 변경 --%>
	        <input type="text" class="userId" id="userId" name="userId" value="${user.userId}" required />
	      </layout:FieldRow>          
          <layout:FieldRow label="비밀번호" inputId="safetyQuantity" help="비밀번호 재설정 버튼을 누르시오.">
            <input type="text" class="password" id="password" name="password" required readonly/>
          </layout:FieldRow>

          <layout:FieldRow label="이름" inputId="safetyQuantity" help="이름을 입력하시오.">
            <input type="text" class="userName" id="userName" name="userName" value="${user.userName}" />
          </layout:FieldRow>
          
          <layout:FieldRow label="전화번호" inputId="safetyQuantity" help="전화번호를 입력하시오.">
            <input type="text" class="phone" id="phone" name="phone" value="${user.phone}" />
          </layout:FieldRow>
          
          <layout:FieldRow label="이메일" inputId="safetyQuantity" help="이메일을 입력하시오.">
            <input type="email" class="email" id="email" name="email" value="${user.email}"/>
          </layout:FieldRow>     
          <layout:FieldRow label="상태" inputId="status" help="계정 상태를 선택하세요.">
		  <select class="form-control" id="status" name="status">
		    <option value="ACTIVE" <c:if test="${user.status eq 'ACTIVE'}">selected</c:if>>활성</option>
		    <option value="INACTIVE" <c:if test="${user.status eq 'INACTIVE'}">selected</c:if>>비활성</option>
		  </select>
		</layout:FieldRow>
               
        </layout:Section>

        <common:Actions>
          <%-- 취소/저장 순서를 일관되게 유지합니다. --%>
          <common:ReturnLink href="${listUrl}">목록으로</common:ReturnLink>
          <button type="submit" class="btn btn-primary ml-2">저장</button>
        </common:Actions>
      </form>
    </jsp:body>
  </layout:Page>
  
  			<script>
				function resetPassword(){
				
				    const chars =
				        "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
				        "abcdefghijklmnopqrstuvwxyz" +
				        "0123456789";
				
				    let pwd = "";
				
				    for(let i=0; i<10; i++){
				        pwd += chars.charAt(
				            Math.floor(Math.random() * chars.length)
				        );
				    }
				
				    document.getElementById("password").value = pwd;
				}
			</script>
</t:layout>