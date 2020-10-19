class MessagePolicy < ApplicationPolicy
  def create?
    record.board.group.users.include?(user)
  end
end
