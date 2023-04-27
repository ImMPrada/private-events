require 'rails_helper'

RSpec.describe AttendeeToEvent, type: :model do
  subject(:attendee_to_event) { build(:attendee_to_event) }

  describe 'associations' do
    it { is_expected.to belong_to(:attended_event) }
    it { is_expected.to belong_to(:attendee) }
  end
end
