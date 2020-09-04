class MessagesController < ApplicationController
  include CableReady::Broadcaster

  def create
    @group = Group.find(params[:group_id])
    @board = Board.find(params[:board_id])
    @message = @board.messages.create(message_params)

    if @message.save
      cable_ready['board'].insert_adjacent_html(
        selector: '#board-messages',
        position: 'beforeend',
        html: render_to_string(partial: 'message', locals: { message: @message })
      )
      cable_ready.broadcast
      redirect_to group_board_path(@group, @board)
    else
      redirect_to group_board_path(@group, @board)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user: current_user)
  end
end
