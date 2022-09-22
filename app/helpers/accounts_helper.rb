module AccountsHelper
  include ActionView::RecordIdentifier

  # check if the given account is followed by current account
  def following?(account)
    current_account&.followees&.include?(account)
  end

  # check if current_account is follwed by given account
  def followed_by?(account)
    if account == current_account
      return true
    end
    account&.followees&.include?(current_account)
  end

  def dom_id_for_follower(follower)
    dom_id(follower)
  end
end
