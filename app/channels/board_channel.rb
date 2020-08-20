class BoardChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'board'
  end
end
