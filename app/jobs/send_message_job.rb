class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    html = ApplicationController.render(
      partial: "messages/new_message",
      locals: { message: message }
    )
    sender = message.user.id

    ActionCable.server.broadcast("board_channel_#{message.board_id}", sender: sender, html: html)
  end
end
