class CommentPolicy < ApplicationPolicy
  def update?
    user == record.account
  end

  def destroy?
    user == record.account
  end
end
