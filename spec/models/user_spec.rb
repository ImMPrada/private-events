require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    describe 'email format' do
      it { is_expected.to allow_value('email@addresse.foo').for(:email) }
      it { is_expected.not_to allow_value('foo').for(:email) }
    end

    describe 'username length' do
      it { is_expected.to validate_length_of(:username).is_at_least(3) }
      it { is_expected.to validate_length_of(:username).is_at_most(20) }
      it { is_expected.not_to allow_value('ab').for(:username) }
      it { is_expected.not_to allow_value('username_with_more_than_20_characters').for(:username) }
      it { is_expected.to allow_value('abcd').for(:username) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:created_events).dependent(:destroy) }
    it { is_expected.to have_many(:attended_events).through(:event_attendees) }
    it { is_expected.to have_many(:event_attendees).dependent(:destroy) }
  end

  describe 'when needs to know if user is creator of attendee' do
    let(:event) { create(:event, creator: user) }
    let(:another_event) { create(:event, creator: user) }
    let(:attendee) { create(:user) }

    before { create(:event_attendee, attendee:, attended_event: event) }

    describe '#attendee_of?' do
      it 'returns true if user is attendee of event' do
        expect(attendee.attendee_of?(event.id)).to be true
      end

      it 'returns false if user is not attendee of event' do
        expect(attendee.attendee_of?(another_event.id)).to be false
      end
    end

    describe '#creator_of?' do
      it 'returns true if user is creator of event' do
        expect(user.creator_of?(event)).to be true
      end

      it 'returns false if user is not attendee of event' do
        expect(attendee.creator_of?(another_event)).to be false
      end
    end
  end
end
