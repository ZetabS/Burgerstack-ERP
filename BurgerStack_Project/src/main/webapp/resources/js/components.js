$(() => {
  // TableRow 행 클릭
  $(".ds-table tbody").on("click", "tr[data-clickable]", (e) => {
    if ($(e.target).closest("a, button, input, select, textarea, label").length > 0) {
      return;
    }

    location.href = $(e.currentTarget).data("href");
  });

  // 목록으로 버튼
  $(".js-return-link").on("click", (e) => {
    const href = $(e.currentTarget).attr("href");
    const storageKey = href ? `page:list:${new URL(href, window.location.origin).pathname}` : null;
    const storedUrl = storageKey ? sessionStorage.getItem(storageKey) : null;

    if (storedUrl) {
      e.preventDefault();
      window.location.href = storedUrl;
    }
  });

  // 목록으로 버튼 동작을 위해서 url 기록
  $(".js-store-current-url").each(() => {
    const storageKey = `page:list:${window.location.pathname}`;
    sessionStorage.setItem(storageKey, window.location.pathname + window.location.search);
  });

  // .js-submit-on-change 클래스가 달린 input 변경 시 자동 새로고침
  $(document).on("change", ".js-submit-on-change", (e) => {
    $(e.currentTarget).closest("form").trigger("submit");
  });
});
