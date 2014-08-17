module BlogHelper
  def blog_title(category)
    category ?  "#{category.title} Entries" : t('posts.index.page_title')
  end

  def category_link(category, selected_category)
    label = category.title + content_tag(:div, category.posts.published.count, class: 'pull-right')
    options = {}
    options.merge!(class: 'active') if category == selected_category
    link_to raw(label), blog_path(category: category.id), options
  end
end
