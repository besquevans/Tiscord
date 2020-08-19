class GroupsController < ApplicationController
  def create
    @group = Group.find(params[:id])
    @board = Boards.create(board_params)
    if @board.save 
      redirect_to @group, notice: "group create success"
    else
      redirect_to @group, notice: "group create false"
    end
  end

  private
  
  def board_params 
    params.require(:board).permit(:name)
  end
end