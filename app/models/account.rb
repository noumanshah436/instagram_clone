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


  def self.search(keyword)
    puts "keyword:#{keyword}"
    if keyword != ""
      where('name LIKE ?', "%#{keyword}%")
    else
      nil
    end
  end

end
