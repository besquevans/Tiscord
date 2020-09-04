class Group < ApplicationRecord
  validates :name, presence: true
  validates :manager_id, presence: true

  has_many :boards, dependent: :destroy

  mount_uploader :avatar, AvatarUploader   #carrierwave
end
