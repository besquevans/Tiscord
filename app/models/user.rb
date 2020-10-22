class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :email, presence: true

  mount_uploader :avatar, AvatarUploader   #carrierwave

  has_many :own_groups, foreign_key: :manager_id, class_name: "Group", dependent: :destroy #使用者建立的群組
  has_many :groupusers, foreign_key: :user_id, dependent: :destroy  #記錄使用者與群組的中間表
  has_many :groups, through: :groupusers   #使用者參加的群組
  has_many :messages, dependent: :destroy

  after_create :create_own_group

  def create_own_group #建立預設群組
    group = Group.create(name: "my first group", manager_id: self.id)
    group.boards.create(name: "my first board")
    group.users << self
  end

  def avatar_url
    avatar.url ? avatar.url : "/default_avatar.png"
  end
end
