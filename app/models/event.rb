class Event < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  belongs_to :creator, class_name: 'User'
  has_many :attendee_to_events, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :attendee_to_events
end
