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
  end
end
