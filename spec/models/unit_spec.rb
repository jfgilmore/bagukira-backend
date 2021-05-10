# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Unit, type: :model do
  subject { build(:unit) }

  describe 'validations' do
    it 'has valid factory' do
      expect(build(:unit)).to be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:unit_type) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:tickets) }
  end
end
