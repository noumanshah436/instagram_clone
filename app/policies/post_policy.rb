class PostPolicy < ApplicationPolicy
  def edit?
    user == record.account
  end

  def update?
    user == record.account
  end

  def destroy?
    user == record.account
  end
end
