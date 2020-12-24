class GroupsController < ApplicationController
  def create
    @group = Group.create(group_params)
    @board = @group.boards.create(name: "First board")
    @group.users << current_user

    if @group.save && @board.save
      redirect_to(group_board_path(group_id: @group.id, id: @board.id), notice: "Group create success!")
    else
      redirect_back(fallback_location:"/", alert: "Group create false!")
    end
  end

  private

  def group_params
    params.require(:group).permit(:name).merge!(manager_id: current_user.id)
  end
end
