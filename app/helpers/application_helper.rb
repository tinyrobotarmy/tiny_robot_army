module ApplicationHelper

  def icon_link_label(icon_class, label)
    content_tag(:i, '', class: "fa fa-#{icon_class}") + content_tag(:div, label)
  end

  #decide how this is going to go, probably config maybe settable in the dashboard
  def allow_comments
    true
  end

  def sign_in_out(user)
    user ? link_to(raw(sign_out_label), destroy_session_path(user), method: :delete) :
           link_to(raw(sign_in_label), new_user_session_path)
  end

  def admin_link(user)
    link_to(raw(icon_link_label('fa fa-cogs', t('.admin'))), admin_dashboard_path) if user && user.admin?
  end

  def message_box(message)
    content_provided = message.nil? || message.empty?
    content = link_to(raw('&times;'), '#', :class => 'close')
    content << raw(content_provided ? flash_content : message)
    content_tag 'div', raw(content), :class => 'message-box'
  end

  def flash_content
    content = ''
    flash.each do |key, msg|
      content << content_tag(:div, msg, :class => key)
    end
    content.empty? ? nil : content
  end

  private
  def sign_in_label
    content_tag(:i, '', class: 'fa fa-sign-in') + content_tag(:div, t('.sign_in'))
  end

  def sign_out_label
    content_tag(:i, '', class: 'fa fa-sign-out') + content_tag(:div, t('.sign_out'))
  end
end
