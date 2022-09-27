class Story < ApplicationRecord
  belongs_to :account

  # story pic
  mount_uploader :image, PhotoUploader

  validates :image, presence: true 

end
