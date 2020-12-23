class Message < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :board

  attr_accessor :new_date
end
