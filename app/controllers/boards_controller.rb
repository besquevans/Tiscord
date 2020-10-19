class BoardsController < ApplicationController
  def index
    group = Group.find(params[:group_id])
    board_id = group.boards.first.id
    redirect_to group_board_path(params[:group_id], board_id)  #跳轉到第一個版
  end

  def show
    @groups = current_user.groups #使用者參加的群組
    @group = Group.find(params[:group_id])
    # @newgroup = Group.new

    @boards = @group.boards
    @board = Board.find(params[:id])
    authorize @board     #pundit 使用者權限驗證
    session[:board_id] = @board.id
    # @newboard = Board.new

    @messages = @board.messages.includes(:user).last(10)
    @message = Message.new
    render :index
  end

  def create
    @group = Group.find(params[:group_id])
    @board = @group.boards.create(board_params)
    authorize @board
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
