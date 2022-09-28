class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'Account'
  belongs_to :followee, class_name: 'Account'
end
