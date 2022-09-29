class Account < ApplicationRecord
  default_scope {  order(id: :desc)  }
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
    puts "keyword:#{keyword}"
    where('name LIKE ? ', "%#{keyword}%") if keyword.present?
  end

  def all_follow_requests
    followers.where.not(id: followees.ids)
  end

  def follow(account)
    self.followees << account
  end

  def unfollow(account)
    result = self.followed_users.where(follower_id: self.id, followee_id: account.id).first.delete
    follower = account.followed_users.where(follower_id: account.id , followee_id: self.id )
    if follower.first
      result = follower.first.delete
    end
    return result
  end

  def active?
    self.active
  end


  def my_posts
    self.posts
  end

  def is_friend(current_account)
    return true if self == current_account
    self&.followees&.include?(current_account) && current_account&.followees&.include?(self)
  end
end
