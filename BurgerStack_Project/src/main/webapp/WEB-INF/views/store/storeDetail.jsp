<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점포 상세 정보 조회</title>
</head>

<body>
	
	<t:menubarHO>
<h1>점포 상세 정보 조회</h1>

<form action="${pageContext.request.contextPath}/store/update" method="post">

    <input type="hidden" name="storeId" value="${store.storeId}">

    <h2>점포 정보</h2>

    <div>
        <label>점포명</label>
        <input type="text" name="storeName" value="${store.storeName}">
          
    </div>

    <div>
        <label>상태</label>

		<select name="storeStatus">
		    <option value="OPEN" ${store.storeStatus eq 'OPEN' ? 'selected' : ''}>영업중</option>
		    <option value="TEMP_CLOSED" ${store.storeStatus eq 'TEMP_CLOSED' ? 'selected' : ''}>휴업</option>
		    <option value="CLOSED" ${store.storeStatus eq 'CLOSED' ? 'selected' : ''}>폐점</option>
		</select>
            
    </div>

    <div>
        <label>연락처</label>
        <input type="text" name="storePhone" value="${store.storePhone}">
            
    </div>

    <div>
        <label>주소</label>
        <input type="text" name="storeAddress" value="${store.storeAddress}">
            
    </div>

	    <button type="submit">수정</button>
	    	
    <button type="button"
        onclick="location.href='${pageContext.request.contextPath}/store/list'">
        목록으로
    </button>

</form>

<br>
		
		<script>
		function deleteStore(storeCode) {
		    if(confirm("정말 삭제하시겠습니까?")) {
		        location.href = "${pageContext.request.contextPath}/store/delete?storeCode=" + storeCode;
		    }
		}
		</script>	
	</t:menubarHO>
</body>
</html>