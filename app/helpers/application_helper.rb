module ApplicationHelper
  def sort_link(column, title = nil, options = {})
    title, options = nil, title if title.is_a?(Hash)
    column = column.to_s
    title = column.titleize unless title
    sort_dir = sort_direction(column)

    link_to request.parameters.merge(dir: (sort_dir || options[:dir] || 'asc'), sort: column, page: 1) do
      content_tag(:i, nil, class: sort_class(sort_dir)) + title
    end
  end

  def sort_direction(column)
    if params[:sort] == column
      params[:dir] == 'asc' ? 'desc' : 'asc'
    end
  end

  def sort_class(sort_dir)
    if sort_dir.present?
      sort_dir == 'asc' ? 'icon-sort icon-sort-down' : 'icon-sort icon-sort-up'
    else
      'icon-sort'
    end
  end
end
