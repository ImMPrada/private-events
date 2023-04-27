FactoryBot.define do
  factory :attendee_to_event do
    association :attendee, factory: :user
    association :attended_event, factory: :event
  end
end
