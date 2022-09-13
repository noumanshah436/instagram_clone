class Post < ApplicationRecord
  belongs_to :account
  has_many :photos
end
