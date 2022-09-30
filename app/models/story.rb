class Story < ApplicationRecord
  default_scope { order(id: :desc) }
  belongs_to :account

  mount_uploader :image, PhotoUploader
  validates :image, presence: true

  def self.all_stories
    all.includes(:account)
  end
end
