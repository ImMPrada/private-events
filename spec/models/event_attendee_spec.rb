require 'rails_helper'

RSpec.describe EventAttendee, type: :model do
  subject(:event_attendee) { build(:event_attendee) }

  describe 'associations' do
    it { is_expected.to belong_to(:attended_event) }
    it { is_expected.to belong_to(:attendee) }
  end
end
