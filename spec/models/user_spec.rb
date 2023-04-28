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
    it { is_expected.to have_many(:created_events) }
    it { is_expected.to have_many(:attended_events) }
    it { is_expected.to have_many(:event_attendees) }
  end
end
