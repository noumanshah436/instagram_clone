class AccountSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :image, :website, :bio, :active
end
