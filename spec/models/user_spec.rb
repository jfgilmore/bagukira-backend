require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it { should allow_value('test@gmail.com').for(:email) }
    it { should_not allow_value('test.gmail.com').for(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe 'associations' do
    it { should have_many(:units) }
  end
end
