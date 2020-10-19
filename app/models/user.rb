class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :email, presence: true

  mount_uploader :avatar, AvatarUploader   #carrierwave

  has_many :groupusers, foreign_key: :user_id, dependent: :destroy  #記錄使用者與群組的中間表
  has_many :groups, through: :groupusers   #使用者參加的群組
  has_many :messages, dependent: :destroy
end
