<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<!-- 레이아웃 작업 -->
<t:layout>

<layout:Page
    title="발주 목록"
    description="점포 발주 내역을 조회합니다.">

    <jsp:attribute name="actions">

        <a href="?page=1"
           class="btn btn-secondary">
            초기화
        </a>

    </jsp:attribute>

    <jsp:body>

        <!-- 검색 조건 -->
        <layout:Section title="검색 조건">

            <form id="searchForm"
                  method="get">

                <input type="hidden"
                       name="page"
                       value="1"/>

                <div class="d-flex justify-content-end align-items-center flex-wrap">

                    <!-- 점포 -->
                    <select name="storeId"
                            id="storeId"
                            class="form-control mr-2"
                            style="width:180px;">

                        <option value="">
                            전체점포
                        </option>

                        <c:forEach var="store"
                                   items="${storeList}">

                            <option value="${store.storeId}"
                                ${param.storeId eq store.storeId ? 'selected' : ''}>

                                ${store.storeName}

                            </option>

                        </c:forEach>

                    </select>

                    <!-- 상태 -->
                    <select name="status"
                            id="status"
                            class="form-control mr-2"
                            style="width:180px;">

                        <option value="">전체상태</option>

                        <option value="REQUESTED"
                            ${condition.status eq 'REQUESTED' ? 'selected' : ''}>
                            요청중
                        </option>

                        <option value="PARTIALLY_APPROVED"
                            ${condition.status eq 'PARTIALLY_APPROVED' ? 'selected' : ''}>
                            부분승인
                        </option>

                        <option value="APPROVED"
                            ${condition.status eq 'APPROVED' ? 'selected' : ''}>
                            승인
                        </option>

                        <option value="REJECTED"
                            ${condition.status eq 'REJECTED' ? 'selected' : ''}>
                            반려
                        </option>

                        <option value="CANCELED"
                            ${condition.status eq 'CANCELED' ? 'selected' : ''}>
                            취소
                        </option>

                        <option value="RECEIVED"
                            ${condition.status eq 'RECEIVED' ? 'selected' : ''}>
                            입고완료
                        </option>

                    </select>

                    <!-- 기간 -->
                    <input type="date"
                           class="form-control mr-2"
                           style="width:150px;"
                           id="startDate"
                           name="startDate"
                           value="${condition.startDate}" />

                    <span class="mr-2">~</span>

                    <input type="date"
                           class="form-control mr-2"
                           style="width:150px;"
                           id="endDate"
                           name="endDate"
                           value="${condition.endDate}" />

                </div>

            </form>

        </layout:Section>


        <!-- 발주 목록 -->
        <layout:TableSection
            title="발주 목록"
            description="행을 클릭하면 발주 상세 정보를 확인할 수 있습니다.">

            <table:Table
                isEmpty="${empty list}"
                emptyMessage="조회된 정보가 없습니다.">

                <jsp:attribute name="thead">

                    <tr>
                        <th>발주코드</th>
                        <th>점포명</th>
                        <th>상태</th>
                        <th>품목요약</th>
                        <th class="text-right">총액</th>
                        <th>요청일</th>
                    </tr>

                </jsp:attribute>

                <jsp:attribute name="tbody">

                    <c:forEach var="p"
                               items="${list}">

                        <table:TableRow
                            clickable="true"
                            href="${pageContext.request.contextPath}/admin/purchases/${p.purchaseOrderId}">

                            <table:TextCell
                                value="${p.purchaseCode}" />

                            <table:TextCell
                                value="${p.storeName}" />

                            <table:FitCell>

                                <c:choose>

                                    <c:when test="${p.status eq 'REQUESTED'}">
                                        <span class="badge badge-secondary">
                                            요청중
                                        </span>
                                    </c:when>

                                    <c:when test="${p.status eq 'PARTIALLY_APPROVED'}">
                                        <span class="badge badge-success">
                                            부분승인
                                        </span>
                                    </c:when>

                                    <c:when test="${p.status eq 'APPROVED'}">
                                        <span class="badge badge-success">
                                            승인
                                        </span>
                                    </c:when>

                                    <c:when test="${p.status eq 'REJECTED'}">
                                        <span class="badge badge-danger">
                                            반려
                                        </span>
                                    </c:when>

                                    <c:when test="${p.status eq 'CANCELED'}">
                                        <span class="badge badge-danger">
                                            취소
                                        </span>
                                    </c:when>

                                    <c:when test="${p.status eq 'RECEIVED'}">
                                        <span class="badge badge-info">
                                            입고완료
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="badge badge-warning">
                                            배송중
                                        </span>
                                    </c:otherwise>

                                </c:choose>

                            </table:FitCell>

                            <table:TextCell
                                value="${p.itemSummary}" />

                            <table:MoneyCell
                                value="${p.totalAmount}"
                                suffix="원" />

                            <table:TextCell
                                value="${p.createdAt.toString().replace('T',' ')}" />

                        </table:TableRow>

                    </c:forEach>

                </jsp:attribute>

            </table:Table>

        </layout:TableSection>

        <div class="mt-3 d-flex justify-content-center">

            <t:pagination
                pageInfo="${pageInfo}" />

        </div>

    </jsp:body>

</layout:Page>

</t:layout>
	
<script>
document.addEventListener("DOMContentLoaded", function() {

    const searchForm = document.getElementById("searchForm");
    const storeId = document.getElementById("storeId");
    const status = document.getElementById("status");
    const startDate = document.getElementById("startDate");
    const endDate = document.getElementById("endDate");

    // 오늘 날짜 yyyy-MM-dd
    function formatDate(date) {

        const year = date.getFullYear();
        const month = String(date.getMonth() + 1)
                        .padStart(2, "0");
        const day = String(date.getDate())
                        .padStart(2, "0");

        return year + "-" + month + "-" + day;
    }

    const todayText = formatDate(new Date());

    startDate.setAttribute("max", todayText);
    endDate.setAttribute("max", todayText);

    // 날짜 범위 동기화
    function syncDateLimit() {

        const startValue = startDate.value;
        const endValue = endDate.value;

        if(startValue !== "") {

            endDate.setAttribute(
                "min",
                startValue
            );

        } else {

            endDate.removeAttribute("min");
        }

        if(endValue !== "") {

            startDate.setAttribute(
                "max",
                endValue
            );

        } else {

            startDate.setAttribute(
                "max",
                todayText
            );
        }
    }

    // 날짜 검증
    function validateDateRange() {

        const startValue = startDate.value;
        const endValue = endDate.value;

        if(
            startValue !== ""
            && startValue > todayText
        ){

            alert(
                "시작일은 오늘 이후 날짜를 선택할 수 없습니다."
            );

            startDate.value = "";

            startDate.focus();

            syncDateLimit();

            return false;
        }

        if(
            endValue !== ""
            && endValue > todayText
        ){

            alert(
                "종료일은 오늘 이후 날짜를 선택할 수 없습니다."
            );

            endDate.value = "";

            endDate.focus();

            syncDateLimit();

            return false;
        }

        if(
            startValue !== ""
            && endValue !== ""
            && startValue > endValue
        ){

            alert(
                "시작일은 종료일보다 늦을 수 없습니다."
            );

            startDate.focus();

            syncDateLimit();

            return false;
        }

        return true;
    }

    // 점포 변경시 자동 조회
    // 점포/상태 변경시 자동 조회
    // 날짜 변경시 자동 조회
    [storeId,status,startDate,endDate].forEach(function(target){

        if(!target){
            return;
        }

        target.addEventListener(
            "change",
            function(){

                if(validateDateRange()){

                    searchForm.submit();
                }
            }
        );
    });

    // 날짜 변경
    startDate.addEventListener(
        "change",
        function(){

            validateDateRange();

            syncDateLimit();
        }
    );

    endDate.addEventListener(
        "change",
        function(){

            validateDateRange();

            syncDateLimit();
        }
    );

    // 조회시 검증
    searchForm.addEventListener(
        "submit",
        function(e){

            if(!validateDateRange()){

                e.preventDefault();
            }
        }
    );

    syncDateLimit();
});
</script>
