class BoardPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    record.group.users.include?(user)
  end

  def create?
    record.group.manager == user
  end
end
