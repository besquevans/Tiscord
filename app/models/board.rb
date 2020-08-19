class Board < ApplicationRecord
  validates :name, presence: true

  belongs_to :group
  has_many :messages
end
