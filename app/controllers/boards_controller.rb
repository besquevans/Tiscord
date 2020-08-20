class BoardsController < ApplicationController
  def show 
    @groups = Group.all 
    @group = Group.find(params[:group_id])
    @newgroup = Group.new

    @boards = @group.boards
    @board = Board.find(params[:id])
    @newboard = Board.new 

    @messages = @board.messages
    @message = Message.new
  end

  def create
    @group = Group.find(params[:group_id])
    @newboard = @group.boards.create(board_params)
    if @newboard.save 
      redirect_to group_board_path(@group, @newboard), notice: "group create success"
    else
      redirect_to group_board_path(@group, @newboard), notice: "group create false"
    end
  end

  private
  
  def board_params 
    params.require(:board).permit(:name)
  end
end