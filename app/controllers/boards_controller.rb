class BoardsController < ApplicationController
  before_action :current_group, only: [:index, :show]
  before_action :current_board, only: [:index, :show]

  def index
  end

  def show
    session[:board_id] = @board.id

    @messages = current_board.messages.includes(:user).last(10)
    set_message_new_date
    @message = Message.new
    render :index
  end

  def create
    @board = current_group.boards.create(board_params)

    if @board.save
      redirect_to group_board_path(@group, @board), notice: "board create success"
    else
      redirect_to group_board_path(@group, @board), notice: "board create false"
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end
end
