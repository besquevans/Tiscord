class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_user

  helper_method :current_group, :current_board

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :invited_code])
  end

  def set_user
    if user_signed_in?
      session[:user_id] = current_user.id
    end
  end

  def current_group
    @groups ||= current_user.groups #使用者參加的群組

    if params[:group_id]
      @group ||= @groups.find(params[:group_id])
    else
      @group ||= @groups.first
    end
  end

  def current_board
    @boards ||= current_group.boards.includes(:messages)

    if params[:id]
      @board ||= @boards.find(params[:id])
    else
      @board ||= @boards.first
    end
  end

  def set_message_new_date
    @messages.each_with_index do |message, index|
      if message.created_at.strftime("%F") != @messages[index - 1].created_at.strftime("%F")
        message.new_date = true
      end
    end
  end
end
