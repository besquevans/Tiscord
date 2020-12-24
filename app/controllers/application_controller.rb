class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_user

  helper_method :all_groups, :current_group, :all_boards, :current_board

  private

  def configure_permitted_parameters #透過devise 註冊使用者時 加入新的 params 可接收資料
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :invited_code])
  end

  def friendly_id  #使用SHA1帶入時間和隨機數產生10位數的新id
    Digest::SHA1.hexdigest([Time.now, rand].join)[1..10]
  end

  def set_user
    if user_signed_in?
      session[:user_id] = current_user.id
    end
  end

  def all_groups #使用者參加的群組
    @groups ||= current_user.groups.includes(:boards)
  end

  def current_group #當前群組
    if params[:group_id]
      @group = all_groups.select{|g| g.slug == params[:group_id]}.first
    else
      @group ||= all_groups.first
    end
  end

  def all_boards #目前群組的看板
    @boards ||= current_group.boards
  end

  def current_board #當前看板
    if params[:id]
      @board ||= all_boards.select{|b| b.id == params[:id].to_i}.first
    else
      @board ||= all_boards.first
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
