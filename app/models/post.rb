class Post < ApplicationRecord
  belongs_to :account
  has_many :photos, dependent: :delete_all
  has_many :likes, -> {order(:id => :desc)}, dependent: :delete_all  # we use id instead of created_at bec id has index table which make it fast
  has_many :comments, -> {order(:id => :desc)}, dependent: :delete_all

  def is_belongs_to? account
    Post.find_by(account_id: account.id, id:id)
  end

  def is_liked account
    Like.find_by(account_id: account.id, post_id:id) #  this will give Like object if user liked the post
  end

end
