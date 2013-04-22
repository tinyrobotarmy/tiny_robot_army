class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin!
  layout 'admin'

  def dashboard

  end

  protected
  def require_admin!
    render file: "#{Rails.root}/public/403", format: :html, status: 403 unless current_user.admin?
  end
end
