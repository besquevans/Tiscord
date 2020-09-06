class GroupsController < ApplicationController
  def index
    @groups = Group.all
    @newgroup = Group.new

    # @baords = @groups.map{|group| group.boards.first}
  end

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
    image_url = "https://picsum.photos/500/500/?random=#{rand(1000)}"
    params.require(:group).permit(:name).merge(manager_id: current_user.id).merge(remote_avatar_url: image_url)
  end
end
