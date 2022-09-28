class Account < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy

  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: { maximum: 50 }

  # profile pic
  mount_uploader :image, PhotoUploader

  # to get prople we are following
  has_many :followed_users, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  # user.followees    get people that         user is following
  has_many :followees, through: :followed_users, dependent: :destroy

  # to get people that are follwing us
  has_many :following_users, class_name: "Follow", foreign_key: "followee_id", dependent: :destroy
  # user.followees    get people that         user is following
  has_many :followers, through: :following_users, dependent: :destroy

  # methods
  def self.search(keyword)
    puts "keyword:#{keyword}"
    where('name LIKE ?', "%#{keyword}%") if keyword.present?
  end

  def all_follow_requests
    followers.where.not(id: followees.ids)
  end

  def follow(account)
    self.followees << account
  end

  def unfollow(account)
    self.followed_users.where(follower_id: self.id, followee_id: account.id).first.delete
  end




end

# 5:00
