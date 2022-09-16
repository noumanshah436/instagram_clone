class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :account

  # creating parent has many child association ( one comment(parent) has many sub_comments )
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, -> {order(:id => :desc)},  foreign_key: :parent_id , dependent: :delete_all

  validates :content, presence: true, length: {maximum: 500}

end
