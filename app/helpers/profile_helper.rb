module ProfileHelper
  # check if the given account is followed by current account
  def following?(account)
    current_account&.followees&.include?(account)
  end

  def friend?(account)
    return true if account == current_account

    account&.followees&.include?(current_account) && current_account&.followees&.include?(account)
  end
end
