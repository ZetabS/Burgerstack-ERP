$(() => {
  const formatDate = (date) => {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const day = String(date.getDate()).padStart(2, "0");

    return `${year}-${month}-${day}`;
  };

  const todayText = formatDate(new Date());

  const syncDateRangeFilter = ($filter) => {
    const $startDate = $filter.find(".js-date-range-filter-start");
    const $endDate = $filter.find(".js-date-range-filter-end");

    if ($startDate.length === 0 || $endDate.length === 0) {
      return;
    }

    const startValue = $startDate.val();
    const endValue = $endDate.val();

    if (!endValue || endValue > todayText) {
      $startDate.attr("max", todayText);
    } else {
      $startDate.attr("max", endValue);
    }

    $endDate.attr("max", todayText);

    if (startValue) {
      $endDate.attr("min", startValue);
    } else {
      $endDate.removeAttr("min");
    }
  };

  const normalizeDateRangeFilter = ($filter) => {
    const $startDate = $filter.find(".js-date-range-filter-start");
    const $endDate = $filter.find(".js-date-range-filter-end");

    if ($startDate.length === 0 || $endDate.length === 0) {
      return true;
    }

    const startValue = $startDate.val();
    const endValue = $endDate.val();

    if (startValue && startValue > todayText) {
      $startDate.val("");
    }

    if (endValue && endValue > todayText) {
      $endDate.val("");
    }

    if ($startDate.val() && $endDate.val() && $startDate.val() > $endDate.val()) {
      $endDate.val("");
    }

    syncDateRangeFilter($filter);

    if ($startDate.val() && $endDate.val() && $startDate.val() > $endDate.val()) {
      return false;
    }

    return true;
  };

  $(".js-date-range-filter").each((_, filter) => {
    syncDateRangeFilter($(filter));
  });

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

  $(document).on("change", ".js-date-range-filter-start, .js-date-range-filter-end", (e) => {
    normalizeDateRangeFilter($(e.currentTarget).closest(".js-date-range-filter"));
  });

  $(document).on("submit", "form", (e) => {
    const $form = $(e.currentTarget);
    let isValid = true;

    $form.find(".js-date-range-filter").each((_, filter) => {
      if (!normalizeDateRangeFilter($(filter))) {
        isValid = false;
      }
    });

    if (!isValid) {
      e.preventDefault();
    }
  });
});
