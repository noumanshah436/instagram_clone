class Photo < ApplicationRecord
  default_scope { order(id: :desc) }

  validates :image, presence: true

  belongs_to :post, dependent: :destroy
  mount_uploader :image, PhotoUploader
end
