class Event < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :past, -> { where('start_date <= ?', DateTime.now) }
  scope :future, -> { where('start_date > ?', DateTime.now) }

  belongs_to :creator, class_name: 'User'
  has_many :event_attendees, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :event_attendees
end
