class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  layout 'admin'

  def dashboard

  end

  protected
  def require_admin!
    render file: "#{Rails.root}/public/403", format: :html, status: 403 unless current_user.admin?
  end
end
