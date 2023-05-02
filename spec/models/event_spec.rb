require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { build(:event) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:creator) }
    it { is_expected.to have_many(:attendees).through(:event_attendees) }
    it { is_expected.to have_many(:event_attendees).dependent(:destroy) }
  end

  describe 'scopes' do
    let(:past_event) { create(:event, start_date: 1.day.ago, end_date: 1.day.ago + 1.hour) }
    let(:future_event) { create(:event, start_date: 1.day.from_now, end_date: 1.day.from_now + 1.hour) }

    describe '.expired' do
      it 'returns expired events' do
        expect(described_class.expired).to eq([past_event])
      end
    end

    describe '.active' do
      it 'returns active events' do
        expect(described_class.active).to eq([future_event])
      end
    end
  end
end
