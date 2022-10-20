class AccountSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :image
end
