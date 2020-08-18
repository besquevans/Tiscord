class Group < ApplicationRecord
  validates :name, presence: true
  validates :manager_id, presence: true
end
