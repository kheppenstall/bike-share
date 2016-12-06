module Pagination
  
  ITEMS_PER_PAGE = 30
  
  def on_page(items, page_num)
    range      = (((page_num - 1) * ITEMS_PER_PAGE)..(page_num * ITEMS_PER_PAGE - 1))
    items[range]
  end

  def total_pages(item_count)
    (item_count / 30.to_f).ceil
  end
  
  def next_page(page_num, item_count)
    page_num + 1 if page_num != total_pages(item_count)
  end

  def previous_page(page_num)
    page_num - 1 if page_num != 1
  end
end