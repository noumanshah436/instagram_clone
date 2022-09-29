class StoryPolicy < ApplicationPolicy
  def destroy?
    user == record.account
  end
end
