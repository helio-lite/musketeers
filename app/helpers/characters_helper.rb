module CharactersHelper

  # ソート用メソッド
  def sort_order(column, title, hash_params = {})
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, { column: column, direction: direction }.merge(hash_params), class: "sort_header #{css_class}"
  end

end
