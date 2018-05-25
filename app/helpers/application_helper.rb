module ApplicationHelper

  def sortable_column(column, state: {}, title: nil)
    title ||= column.capitalize
    css_class = []

    if state[:field] && state[:field].to_sym == column
      css_class << 'current'
      css_class << state[:direction]

      direction = state[:direction] == 'asc' ? 'desc' : 'asc'
    else
      direction = :asc
    end

    link_to title, { field: column, direction: direction }, { class: css_class.join(' ')}
  end

end
