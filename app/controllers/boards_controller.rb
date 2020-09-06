class BoardsController < ApplicationController
  def index
    @groups = Group.all
    @group = Group.find(params[:group_id])
    @boards = @group.boards
  end

  def show
    @groups = Group.all
    @group = Group.find(params[:group_id])
    # @newgroup = Group.new

    @boards = @group.boards
    @board = Board.find(params[:id])
    session[:board_id] = @board.id
    # @newboard = Board.new

    @messages = @board.messages.includes(:user).last(10)
    @message = Message.new
    render :index
  end

  def create
    @group = Group.find(params[:group_id])
    @board = @group.boards.create(board_params)
    if @board.save
      redirect_to group_boards_path(@group), notice: "group create success"
    else
      redirect_to group_boards_path(@group), notice: "group create false"
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end
end
