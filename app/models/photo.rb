class Photo < ApplicationRecord
  validates :image, presence: :true  

  belongs_to :post, dependent: :destroy
  mount_uploader :image, PhotoUploader

end
