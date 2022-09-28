class Story < ApplicationRecord
  belongs_to :account

  mount_uploader :image, PhotoUploader

  validates :image, presence: true

  def self.all_stories
    self.all.includes(:account).order("id desc")
  end
end
