class Board < ApplicationRecord
  extend FriendlyId
  friendly_id :friendly_id, use: :slugged
  validates :name, presence: true
  before_destroy :board_cannot_less_one

  belongs_to :group
  has_many :messages, dependent: :destroy

  def friendly_id  #使用SHA1帶入時間和隨機數產生10位數的新id
    Digest::SHA1.hexdigest([Time.now, rand].join)[1..10]
  end

  private

  def board_cannot_less_one
    if self.group.boards.count == 1
      errors[:base] << "cannot delete if less 1 board"
      throw(:abort)
    end
  end
end
