<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    table.table2 tbody tr:hover {
        background-color: #f5f5f5;
    }
    .content-top{
        display: flex;
    }
    .top-info {
        text-align: left;
        width: 200px;
    }
    td h6 {
        margin: 0;
    }
    h6 .badge {
        font-size: 0.8em;
        padding: 0.25em 0.4em;
        margin: 0;
    }
    .bg-secondary {
        color: #ffffff !important;
    }
    .bg-success {
        color: #ffffff !important;
    }
    .bg-danger {
        color: #ffffff !important;
    }
    .bg-info {
        color: #ffffff !important;
    }
    .bg-warning {
        color: #ffffff !important;
    }
</style>

    <!-- 레이아웃 작업 -->
	<t:layout>
    <div class="outer">
        <h2>발주 목록</h2>
        
        <div class="content-top">
            <div class="top-info">
                
            </div>
            <!-- 검색 -->
            <div class="search-area" align="right">
                <form method="get" id="searchForm">

                        <select name="storeId" onchange="autoSearch()">
                            <option value="">전체점포</option>

                            <c:forEach var="store" items="${storeList}">
                                <option value="${store.storeId}"
                                    <c:if test="${param.storeId == store.storeId}">
                                        selected="selected"
                                    </c:if>>
                                    ${store.storeName}
                                </option>
                            </c:forEach>
                        </select>

                    <select name="status" onchange="autoSearch()">

                        <option value="">전체상태</option>

                        <option value="REQUESTED"
                            ${condition.status eq 'REQUESTED' ? 'selected' : ''}>
                            요청중
                        </option>

                        <option value="PARTIALLY_APPROVED"
                            ${condition.status eq 'PARTIALLY_APPROVED' ? 'selected' : ''}>
                            부분 승인
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
                    <input type="date"
                            id="startDate"
                            name="startDate"
                            max="${today}"
                            value="${condition.startDate}"
                            onchange="validateDate()">
                    ~
                    <input type="date"
                            id="endDate"
                            name="endDate"
                            max="${today}"
                            value="${condition.endDate}"
                            onchange="validateDate();">
                </form>
            </div>
        </div>
        <table class="table2">
            <thead>
                <tr>
                    <th>발주번호</th>
                    <th>점포명</th>
                    <th>상태</th>
                    <th>품목요약</th>
                    <th>총액</th>
                    <th>요청일</th>
                </tr>
            </thead>
            
            <tbody id="purchaseListBody"> 
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="5" style="text-align:center;">
                            조회된 정보가 없습니다.
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="p" items="${list}">
                    <tr style="cursor:pointer;"
                        onclick="location.href='${pageContext.request.contextPath}/admin/purchases/${p.purchaseOrderId}'">
                        <td>${p.purchaseOrderId}</td>
                        <td>${p.storeName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.status eq 'REQUESTED'}">
                                    <h6><span class="badge bg-secondary">요청중</span></h6>
                                </c:when>
                                <c:when test="${p.status eq 'PARTIALLY_APPROVED'}">
                                    <h6><span class="badge bg-success">부분승인</span></h6>
                                </c:when>
                                <c:when test="${p.status eq 'APPROVED'}">
                                    <h6><span class="badge bg-success">승인</span></h6>
                                </c:when>
                                <c:when test="${p.status eq 'CANCELED'}">
                                    <h6><span class="badge bg-danger">발주취소</span></h6>
                                </c:when>
                                <c:when test="${p.status eq 'REJECTED'}">
                                    <h6><span class="badge bg-danger">반려</span></h6>
                                </c:when>
                                <c:when test="${p.status eq 'RECEIVED'}">
                                    <h6><span class="badge bg-info">입고완료</span></h6>
                                </c:when>
                                <c:otherwise>
                                    <h6><span class="badge bg-warning">배송중</span></h6>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${p.itemSummary}</td>
                        <td class="comma-number">${p.totalAmount}</td>
                        <td>${p.createdAt}</td>
                    </tr>
                </c:forEach>      
            </tbody>
        </table>
        <br>
        <t:pagination pageInfo="${pageInfo}"></t:pagination>
	</t:layout>
	
    <script>
        // 페이지 로드시 최초 실행
        $(document).ready(function () {

            const today = new Date().toISOString().split('T')[0];

            $('#endDate').attr('max', today);

            priceFormatting()

        }); //


        // 금액 포멧팅
        function priceFormatting() {
            
            // 클래스가 'comma-number'인 모든 태그 선택
            const elements = document.querySelectorAll('.comma-number');
            
            elements.forEach(el => {
                const num = Number(el.textContent);
                // 숫자가 맞을 때만 변경
                if (!isNaN(num)) {
                el.textContent = num.toLocaleString('ko-KR');
                }
            });
        }

        // 검색어 변경시 자동 검색
        function autoSearch() {
            document.getElementById("searchForm").submit();
        }

        // 날짜 유효성 검사
        function validateDate() {

            const startDate =
                document.getElementById('startDate');

            const endDate =
                document.getElementById('endDate');

            const today =
                new Date().toISOString().split('T')[0];

            endDate.max = today;

            if(endDate.value > today) {

                alert('종료일은 오늘 이후로 선택할 수 없습니다.');

                endDate.value = today;

                return;
            }

            if(startDate.value &&
            endDate.value &&
            startDate.value > endDate.value) {

                alert('시작일은 종료일보다 클 수 없습니다.');

                startDate.value = endDate.value;

                return;
            }

            autoSearch();
        }

        let typing = false;

        // 검색어 입력시 새로고침 방지
        document.addEventListener("focusin", function(e) {
            if (e.target.tagName === "INPUT") {
                typing = true;
            }
        });

        document.addEventListener("focusout", function(e) {
            if (e.target.tagName === "INPUT") {
                typing = false;
            }
        });

        // 5초마다 새로고침
        function refreshPurchaseList() {

            if(typing){
                return;
            }

            $.ajax({
                url : window.location.href,
                success : function(html) {

                    $("#purchaseListBody").html(
                        $(html)
                        .find("#purchaseListBody")
                        .html()
                    );

                    priceFormatting();
                }
            });
            
        }

        setInterval(refreshPurchaseList, 5000);
    </script>
