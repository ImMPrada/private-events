class Event < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  belongs_to :creator, class_name: 'User'
  belongs_to :attendee, class_name: 'User', optional: true
end
