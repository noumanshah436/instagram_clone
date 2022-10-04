FactoryBot.define do
  factory :comment do
    sequence(:id, &:to_s)
    content { 'MyContent' }
    text { 'hello' }
  end
end
