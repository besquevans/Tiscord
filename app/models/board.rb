class Board < ApplicationRecord
  validates :name, presence: true

  belongs_to :group
  has_many :messages, dependent: :destroy

  before_destroy :board_cannot_less_one

  private

  def board_cannot_less_one
    if self.group.boards.count == 1
      errors[:base] << "cannot delete if less 1 board"
      throw(:abort)
    end
  end
end
