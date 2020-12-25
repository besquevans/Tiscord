class GroupsController < ApplicationController
  def create
    @group = Group.new(group_params)
    @board = @group.boards.new(name: "First board")

    if @group.save && @board.save
      @group.users << current_user
      redirect_to(board_path(@board.slug), notice: "Group create success!")
    else
      redirect_back(fallback_location:"/", alert: "Group create false!")
    end
  end

  private

  def group_params
    params.require(:group).permit(:name).merge!(manager_id: current_user.id)
  end
end
