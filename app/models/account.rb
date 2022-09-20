class Account < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: {maximum: 50}

  # profile pic
  mount_uploader :image, PhotoUploader

  ###################
  # to get prople we are following

  has_many :followed_users,   class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  # user.followees    get people that         user is following
  has_many :followees, through: :followed_users , dependent: :destroy

  ###################
  # to get people that are follwing us
  # for the users that are following this user

  has_many :following_users, class_name: "Follow", foreign_key: "followee_id", dependent: :destroy
  # user.followees    get people that         user is following
  has_many :followers, through: :following_users , dependent: :destroy

  ###################

  # methods

  def self.search(keyword)
    puts "keyword:#{keyword}"
    if keyword != ""
      where('name LIKE ?', "%#{keyword}%")
    else
      nil
    end
  end

end

# 5:00
