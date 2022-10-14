class StorySerializer < ActiveModel::Serializer
  attributes :id, :image, :created_at, :updated_at
  belongs_to :account
end
