module VideosHelper
  def get_category_dropdown_tag
    dropdown_label = 'Category<b class="caret"></b>'.html_safe
    link_to dropdown_label, '#', class: 'dropdown-toggle', data: { toggle: 'dropdown' }
  end
end