class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :account

  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, -> { order(id: :desc) }, foreign_key: :parent_id, dependent: :delete_all

  validates :content, presence: true, length: { maximum: 500 }
end
