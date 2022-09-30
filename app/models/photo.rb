class Photo < ApplicationRecord
  belongs_to :post, dependent: :destroy
  default_scope { order(id: :desc) }

  validates :image, presence: true
  mount_uploader :image, PhotoUploader
end
