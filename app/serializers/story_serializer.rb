class StorySerializer < ActiveModel::Serializer
  attributes :id, :image, :created_at, :updated_at, :account

  def account
    object.account
  end
end
