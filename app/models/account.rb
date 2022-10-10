class Account < ApplicationRecord
  default_scope { order(id: :desc) }
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy

  has_many :followed_users, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followees, through: :followed_users, dependent: :destroy

  has_many :following_users, class_name: "Follow", foreign_key: "followee_id", dependent: :destroy
  has_many :followers, through: :following_users, dependent: :destroy

  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: { maximum: 50 }
  mount_uploader :image, PhotoUploader

  # methods
  def self.search(keyword)
    where('name LIKE ? ', "%#{keyword}%") if keyword.present?
  end

  def all_follow_requests
    followers.where.not(id: followees.ids)
  end

  def follow(account)
    followees << account
  end

  def unfollow(account)
    result = followed_users.where(follower_id: id, followee_id: account.id).first.delete
    follower = account.followed_users.where(follower_id: account.id, followee_id: id)
    result = follower.first.delete if follower.first
    result
  end

  def active?
    active
  end

  def my_posts(is_friend)
    if is_friend
      posts
    else
      posts.where('active=true')
    end
  end

  def friend?(current_account)
    return true if self == current_account

    self&.followees&.include?(current_account) && current_account&.followees&.include?(self)
  end
end
