module Pagination

  ITEMS_PER_PAGE = 30

  def on_page(items, page_num)
    items.limit(ITEMS_PER_PAGE).offset((page_num - 1) * ITEMS_PER_PAGE)
  end

  def total_pages(item_count)
    (item_count / ITEMS_PER_PAGE.to_f).ceil
  end

  def next_page(page_num, item_count)
    page_num + 1 unless page_num >= total_pages(item_count)
  end

  def previous_page(page_num)
    page_num - 1 unless page_num <= 1
  end
end
