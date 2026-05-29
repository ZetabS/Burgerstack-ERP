<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점포 상세 정보 조회</title>
</head>
<body>

<h1>점포 상세 정보 조회</h1>

<form action="${pageContext.request.contextPath}/store/update" method="post">

    <input type="hidden" name="storeCode" value="${store.storeCode}">

    <h2>점포 정보</h2>

    <div>
        <label>점포명</label>
        <input type="text" name="storeName" value="${store.storeName}"
            <c:if test="${loginUser.userRole ne 'ADMIN'}">readonly</c:if>>
    </div>

    <div>
        <label>상태</label>
        <input type="text" name="storeStatus" value="${store.storeStatus}"
            <c:if test="${loginUser.userRole ne 'ADMIN'}">readonly</c:if>>
    </div>

    <div>
        <label>연락처</label>
        <input type="text" name="storePhone" value="${store.storePhone}"
            <c:if test="${loginUser.userRole ne 'ADMIN'}">readonly</c:if>>
    </div>

    <div>
        <label>주소</label>
        <input type="text" name="storeAddress" value="${store.storeAddress}"
            <c:if test="${loginUser.userRole ne 'ADMIN'}">readonly</c:if>>
    </div>

    <div>
        <label>상세주소</label>
        <input type="text" name="storeDetailAddress" value="${store.storeDetailAddress}"
            <c:if test="${loginUser.userRole ne 'ADMIN'}">readonly</c:if>>
    </div>

    <c:if test="${loginUser.userRole eq 'ADMIN'}">
        <button type="submit">수정</button>
        <button type="button" onclick="deleteStore('${store.storeCode}')">삭제</button>
    </c:if>

    <button type="button"
        onclick="location.href='${pageContext.request.contextPath}/store/list'">
        목록으로
    </button>

</form>

<br>

<h2>점장 정보</h2>

<!-- 점장 정보는 form 밖에 있음 + name 없음 = update로 안 넘어감 -->
<div>
    <label>아이디</label>
    <input type="text" value="${manager.managerId}" readonly>
</div>

<div>
    <label>이름</label>
    <input type="text" value="${manager.managerName}" readonly>
</div>

<div>
    <label>연락처</label>
    <input type="text" value="${manager.managerPhone}" readonly>
</div>

<div>
    <label>이메일</label>
    <input type="text" value="${manager.managerEmail}" readonly>
</div>

<script>
function deleteStore(storeCode) {
    if(confirm("정말 삭제하시겠습니까?")) {
        location.href = "${pageContext.request.contextPath}/store/delete?storeCode=" + storeCode;
    }
}
</script>

</body>
</html>