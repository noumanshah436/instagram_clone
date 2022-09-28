class Post < ApplicationRecord
  belongs_to :account
  has_many :photos, dependent: :delete_all
  has_many :likes, -> { order(id: :desc) }, dependent: :destroy
  has_many :comments, -> { order(id: :desc) }, dependent: :destroy


  def belongs_to?(account)
    Post.find_by(account_id: account.id, id: id)
  end

  def liked(account)
    Like.find_by(account_id: account.id, post_id: id)
  end

  def active?
    self.active
  end

  def self.posts
    Post.all.includes(:photos, :account, :likes).order("id desc")
  end


end
