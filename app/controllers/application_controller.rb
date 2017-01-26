class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :timezone, :grad_city, :grad_date, :current_city, :current_state])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :timezone, :grad_city, :grad_date, :current_city, :current_state])
  end

  def authenticate_authorized_user
    unless current_admin || current_user
      flash[:warning] = "You do not have access to that page!"
      redirect_to "/"
    end
  end
end
