class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable # , :validatable

  has_many :created_events, foreign_key: :creator_id, class_name: 'Event', dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'invalid email address'
  }

  validates :username,
            presence: true,
            uniqueness: true,
            length: { in: 3..20,
                      wrong_length: 'must be between 3 and 20 characters' }
end
