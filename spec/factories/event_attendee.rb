FactoryBot.define do
  factory :event_attendee do
    association :attendee, factory: :user
    association :attended_event, factory: :event
  end
end
