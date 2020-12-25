class Group < ApplicationRecord
  extend FriendlyId
  friendly_id :friendly_id, use: :slugged
  mount_uploader :avatar, AvatarUploader   #carrierwave

  validates :name, presence: true
  validates :manager_id, presence: true

  belongs_to :manager, foreign_key: :manager_id, class_name: "User"  #群組的建立者
  has_many :groupusers, foreign_key: :group_id, dependent: :destroy  #記錄使用者與群組的中間表
  has_many :users, through: :groupusers   #群組裡的使用者
  has_many :boards, dependent: :destroy

  def avatar_url #群組沒有大頭照 -> 顯示預設圖
    avatar.url ? avatar.url : "/default_group.png"
  end

  def friendly_id  #使用SHA1帶入時間和隨機數產生10位數的新id
    Digest::SHA1.hexdigest([Time.now, rand].join)[1..10]
  end
end
