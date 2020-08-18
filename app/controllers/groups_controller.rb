class GroupsController < ApplicationController
  def index 
    @groups = Group.all
    @group = Group.new
  end

  def create 
    @group = Group.create(group_params)
    if @group.save
      redirect_to groups_path, notice: "Group create success"
    else
      redirect_to groups_path, notice: "Group create false"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name).merge(manager_id: current_user.id)
  end
end