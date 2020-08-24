class GroupsController < ApplicationController
  def index 
    @groups = Group.all
    @newgroup = Group.new

    # @baords = @groups.map{|group| group.boards.first}
  end

  # def show 
  #   @groups = Group.all
  #   @newgroup = Group.new
  #   @group = Group.find(params[:id])

  #   @boards = @group.boards
  #   @board = Board.new

  #   @messages = @board.messages
  #   @message = Message.new
  # end

  def create 
    @group = Group.create(group_params)
    @board = @group.boards.create(name: "First board")
    if @group.save && @board.save
      redirect_to groups_path, notice: "Group create success"
    else
      redirect_to groups_path, notice: "Group create false"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name).merge(manager_id: current_user.id)
  end

  def board_params 
    params.require(:board).permit(:name)
  end
end