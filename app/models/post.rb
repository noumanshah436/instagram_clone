class Post < ApplicationRecord
  default_scope { order(id: :desc) }

  belongs_to :account
  has_many :photos, -> { order(id: :desc) }, dependent: :destroy
  has_many :likes, -> { order(id: :desc) }, dependent: :destroy
  has_many :comments, -> { order(id: :desc) }, dependent: :destroy

  validates :content, presence: true

  def belongs_to?(account)
    Post.find_by(account_id: account.id, id: id)
  end

  def liked(account)
    Like.find_by(account_id: account.id, post_id: id)
  end

  def active?
    self.active
  end

  def self.all_posts
    Post.all.includes(:photos, :account, :likes)
  end

  def parent_comments
    self.comments.where(parent_id: nil)
  end

end
