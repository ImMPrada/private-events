FactoryBot.define do
  factory :event do
    association :creator, factory: :user

    title { Faker::Quote.famous_last_words }
    description { Faker::Quote.yoda }
    start_date { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    end_date { Faker::Date.between(from: 2.days.ago, to: Date.today) }
  end
end
