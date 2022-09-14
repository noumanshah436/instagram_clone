class Photo < ApplicationRecord
  validates :image, presence: :true
  belongs_to :post
  mount_uploader :image, PhotoUploader
end
