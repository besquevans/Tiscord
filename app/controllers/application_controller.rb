class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_user

  helper_method :is_new_date?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def set_user
    if user_signed_in?
      session[:user_id] = current_user.id
    end
  end

  def is_new_date?(message)
    Message.find(message.id - 1).created_at.strftime("%F") != message.created_at.strftime("%F")
  end
end
