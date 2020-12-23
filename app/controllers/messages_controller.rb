class MessagesController < ApplicationController
  # before_action :current_board, only: [:create]
  # include CableReady::Broadcaster

  def create
    @message = current_board.messages.create(message_params)
    authorize @message
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
