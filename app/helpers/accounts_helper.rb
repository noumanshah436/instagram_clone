module AccountsHelper
  include ActionView::RecordIdentifier

  def following?(account)
    current_account&.followees&.include?(account)
  end

  def dom_id_for_follower(follower)
    dom_id(follower)
  end
end
