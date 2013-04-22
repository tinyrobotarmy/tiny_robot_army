module AdminHelper
  def site_link_label
    content_tag(:i, '', class: 'icon-globe') + content_tag(:div, t('.site'))
  end

  def dashboard_link_label
    content_tag(:i, '', class: 'icon-dashboard') + content_tag(:div, t('.dashboard'))
  end

  def posts_link_label
    content_tag(:i, '', class: 'icon-edit') + content_tag(:div, t('.posts'))
  end

  def categories_link_label
    content_tag(:i, '', class: 'icon-tasks') + content_tag(:div, t('.categories'))
  end
end
