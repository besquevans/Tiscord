class BoardsController < ApplicationController
  def index
  end

  def show
    @board = Board.find(params[:id])
    @group = @board.group
    @messages = @board.messages.includes(:user).last(10)
    set_message_new_date
    @message = Message.new
    render :index
  end

  def create
    @group = Group.find(params[:group_id])
    @board = @group.boards.create(board_params)

    if @board.save
      redirect_to board_path(@board.slug), notice: "Board create success!"
    else
      redirect_back(fallback_location:"/", alert: "Board create false!")
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end
end
