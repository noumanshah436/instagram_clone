FactoryBot.define do
  factory :comment do
    association :post 
    sequence(:id, &:to_s)
    content { 'MyContent' }
  end
end
