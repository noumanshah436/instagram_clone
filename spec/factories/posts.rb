FactoryBot.define do
  factory :post do
    association :account
    content { "content" }
  end
end
