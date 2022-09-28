class Post < ApplicationRecord
  belongs_to :account
  has_many :photos, dependent: :delete_all
  has_many :likes, -> { order(id: :desc) }, dependent: :delete_all  # we use id instead of created_at bec id has index table which make it fast
  has_many :comments, -> { order(id: :desc) }, dependent: :delete_all

  # before_save :check_images
  # validates :content, presence: true, length: { maximum: 100 }

  def belongs_to?(account)
    Post.find_by(account_id: account.id, id: id)
  end

  def liked(account)
    Like.find_by(account_id: account.id, post_id: id) #  this will give Like object if user liked the post
  end

  def active?
    self.active
  end

  def self.posts
    Post.all.includes(:photos, :account, :likes).order("id desc")
  end

  # def check_images

  # end

end
