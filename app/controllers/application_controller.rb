class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :admin]
  end

  def require_user!
    render file: "#{Rails.root}/public/422", format: :html, status: 422 unless current_user.present?
  end
end
