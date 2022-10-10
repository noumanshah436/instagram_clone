FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "name#{n}" }
    email { "#{name}@gmail.com".downcase }
    password { 'nouman' }
    confirmed_at { DateTime.now }
  end
end
