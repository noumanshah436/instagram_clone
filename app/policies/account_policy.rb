class AccountPolicy < ApplicationPolicy
  # class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   def resolve
  #     scope.all
  #   end

  # end

  def show?
    print "user:"
    p user     # user is the current user
    print "record:"
    p record    #t he record is the object we passed  in the action

    user == record  # return true if current user is same as the user that accessing the show page
  end
end
