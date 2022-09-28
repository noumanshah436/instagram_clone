class AccountPolicy < ApplicationPolicy
  def show?
    record.is_active?
  end
end
