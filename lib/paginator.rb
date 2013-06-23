# coding: utf-8

class Paginator
  Position = Struct.new :page, :index_in_page

  def initialize total_count, max_page, max_per_page
    @total_count = [total_count, max_page * max_per_page].min
    @max_page = max_page
    @max_per_page = max_per_page
  end

  def min_per_page
    (@total_count.to_f / @max_page).ceil
  end

  def at index
    page = (index / min_per_page)
    index_in_page = index - page * min_per_page - 1
    Position.new page, index_in_page
  end

  def random
    index = rand @total_count
    at index
  end
end