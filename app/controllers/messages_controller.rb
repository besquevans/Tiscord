class MessagesController < ApplicationController
  # include CableReady::Broadcaster

  def create
    @group = Group.find(params[:group_id])
    @board = Board.find(params[:board_id])
    @message = @board.messages.create(message_params)
    @message.save

    SendMessageJob.perform_later(@message)


    # cable_ready["board_channel_#{@board.id}"].insert_adjacent_html(
    #   selector: "#message-items",
    #   position: "beforeend",
    #   html: render_to_string(partial: "message", locals: { message: @message })
    # )
    # cable_ready.broadcast
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user: current_user)
  end
end
