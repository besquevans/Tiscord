class MessagesController < ApplicationController
  def create 
    @group = Group.find(params[:group_id])
    @board = Board.find(params[:board_id])
    @message = @board.messages.create(message_params)
    if @message.save 
      redirect_to group_board_path(@group, @board), notice: "create message success"
    else
      redirect_to group_board_path(@group, @board), notice: "create message false"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user: current_user)
  end
end