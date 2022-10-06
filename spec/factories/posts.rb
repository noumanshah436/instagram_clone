FactoryBot.define do
  factory :post do
    association :account
    content { "content" }

    # after(:create) do |post|
    #   post.photos.create(image: File.open("#{Rails.root}/app/assets/images/default2.png"))
    # end
  end
end
