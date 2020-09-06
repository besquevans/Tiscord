class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    html = ApplicationController.render(
      partial: "messages/message",
      locals: { message: message }
    )
    ActionCable.server.broadcast "board_channel_#{message.board_id}", html: html
  end
end
