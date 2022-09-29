class AccountPolicy < ApplicationPolicy
  def show?
    record.is_active?  || ( record == user )
  end
end
