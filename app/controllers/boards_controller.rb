class BoardsController < ApplicationController
  before_action :find_groups_and_boards, only: [:index, :show]

  def index
  end

  def show
    if params[:id]
      @board = Board.find(params[:id])
    else
      @board = @group.boards.first
    end

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
      redirect_to group_board_path(@group, @board), notice: "board create success"
    else
      redirect_to group_board_path(@group, @board), notice: "board create false"
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end

  def find_groups_and_boards
    @groups = current_user.groups #使用者參加的群組

    if params[:group_id]
      @group = Group.find(params[:group_id])
    else
      @group = current_user.groups.first
    end

    @boards = @group.boards
  end
end
