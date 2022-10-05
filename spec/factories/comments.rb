FactoryBot.define do
  factory :comment do
    association :account
    association :post
    content { 'MyContent' }
  end
end
