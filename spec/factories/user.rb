FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 3...20) }
    email { Faker::Internet.email }
  end
end
