<%@ tag language="java" pageEncoding="UTF-8" %>

<div class="layout__menu">
  <%-- 점포 관리 --%>
  <div class="layout__menu-item active">
    <div class="layout__menu-title">점포 관리</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/owner/store">점포 상세 정보 조회</a></li>
    </ul>
  </div>

  <%-- 입고 관리 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">입고 관리</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/owner/receipts/planned">입고 예정 목록</a></li>
      <li><a href="/burgerstack/owner/receipts">입고 이력 목록</a></li>
    </ul>
  </div>

  <%-- 일일 마감 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">일일 마감</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/owner/closings/new">일일 재고 마감</a></li>
      <li><a href="/burgerstack/owner/closings">마감 이력 목록</a></li>
    </ul>
  </div>

  <%-- 재고 관리 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">재고 관리</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/owner/inventories">재고 목록 조회</a></li>
      <li><a href="/burgerstack/owner/inventory-transactions?abnormalOnly=true">이상 재고 변동 조회</a></li>
      <li><a href="/burgerstack/owner/inventory-transactions">재고 변동 이력 조회</a></li>
    </ul>
  </div>

  <%-- 발주 관리 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">발주 관리</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/owner/purchases/new">발주 요청</a></li>
      <li><a href="/burgerstack/owner/purchases">발주 목록 조회</a></li>
    </ul>
  </div>

  <%-- 자재 관리 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">자재 관리</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/owner/materials">자재 목록 조회</a></li>
    </ul>
  </div>

  <%-- 공지사항 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">공지사항</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/owner/notices">공지사항 목록</a></li>
    </ul>
  </div>

  <%-- 문의사항 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">문의사항</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/owner/inquiries">문의사항 목록</a></li>
      <li><a href="/burgerstack/owner/inquiries/new">문의사항 등록</a></li>
    </ul>
  </div>
</div>

<script>
  $(() => {
    $(".layout__menu-title").on("click", (e) => {
      const $item = $(e.currentTarget).closest(".layout__menu-item");
      const $submenu = $item.find(".layout__submenu");

      const isActive = $submenu.attr("data-is-active") === "true";
      $submenu.attr("data-is-active", String(!isActive));
    });
  });

  // 현재 탭 자동 열림
  $(() => {

    const currentPath = window.location.pathname;

    $(".layout__submenu a").each(function() {

        const href = $(this).attr("href");

        if(currentPath.startsWith(href)) {

            $(this)
                .closest(".layout__submenu")
                .attr("data-is-active", "true");
        }
    });
  });
</script>
