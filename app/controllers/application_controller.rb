class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_user

  helper_method :all_groups, :all_boards

  private

  def configure_permitted_parameters #透過devise 註冊使用者時 加入新的 params 可接收資料
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :invited_code])
  end

  def set_user
    if user_signed_in?
      session[:user_id] = current_user.id
    end
  end

  def all_groups #使用者參加的群組
    @groups ||= current_user.groups.includes(:boards)
  end

  def all_boards #目前群組的看板
    if @board
      @boards ||= @board.group.boards
    else
      @boards ||= all_groups.first.boards
    end
  end

  def set_message_new_date #判斷訊息是否為當天第一則
    @messages.each_with_index do |message, index|
      if message.created_at.strftime("%F") != @messages[index - 1].created_at.strftime("%F")
        message.new_date = true
      end
    end
  end
end
