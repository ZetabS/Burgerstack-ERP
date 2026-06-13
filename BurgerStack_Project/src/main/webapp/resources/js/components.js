$(() => {
  // TableRow
  $(".data-table tbody").on("click", "tr[data-clickable]", (e) => {
    if ($(e.target).closest("a, button, input, select, textarea, label").length > 0) {
      return;
    }

    location.href = $(e.currentTarget).data("href");
  });
});

