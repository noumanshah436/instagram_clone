class Like < ApplicationRecord
  belongs_to :post
  belongs_to :account

  # The scope option to the Rails uniqueness validation rule allows us to specify additional columns to consider when checking for uniqueness.
  # validates :account_id, uniqueness: {scope: :post_id}
end
