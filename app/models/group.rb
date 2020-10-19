class Group < ApplicationRecord
  validates :name, presence: true
  validates :manager_id, presence: true

  has_many :groupusers, foreign_key: :group_id, dependent: :destroy  #記錄使用者與群組的中間表
  has_many :users, through: :groupusers   #群組裡的使用者
  has_many :boards, dependent: :destroy

  mount_uploader :avatar, AvatarUploader   #carrierwave
end
