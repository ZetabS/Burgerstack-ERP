<%@ tag language="java" pageEncoding="UTF-8" %>

<div class="layout__menu">
  <%-- 점주 관리 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">점주 관리</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/admin/users">점주 목록</a></li>
      <li><a href="/burgerstack/admin/users/new">점주 등록</a></li>
    </ul>
  </div>

  <%-- 점포 관리 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">점포 관리</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/admin/stores">점포 목록</a></li>
      <li><a href="/burgerstack/admin/stores/new">점포 등록</a></li>
    </ul>
  </div>

  <%-- 재고 관리 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">점포 재고 모니터링</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/admin/inventories">점포 재고 목록</a></li>
      <li><a href="/burgerstack/admin/inventory-transactions">재고 변동 이력</a></li>
      <li><a href="/burgerstack/admin/receipts">입고 이력</a></li>
      <li><a href="/burgerstack/admin/closings">마감 이력</a></li>
    </ul>
  </div>

  <%-- 발주 관리 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">발주 관리</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/admin/purchases?status=REQUESTED">승인 대기 발주</a></li>
      <li><a href="/burgerstack/admin/purchases">발주 이력</a></li>
    </ul>
  </div>

  <%-- 자재 관리 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">자재 관리</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/admin/materials">자재 목록</a></li>
      <li><a href="/burgerstack/admin/materials/new">자재 등록</a></li>
    </ul>
  </div>

  <%-- 공지사항 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">공지사항</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/admin/notices">공지사항 목록</a></li>
      <li><a href="/burgerstack/admin/notices/new">공지사항 등록</a></li>
    </ul>
  </div>

  <%-- 문의사항 --%>
  <div class="layout__menu-item">
    <div class="layout__menu-title">문의사항</div>

    <ul class="layout__submenu">
      <li><a href="/burgerstack/admin/inquiries">문의사항 목록</a></li>
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
