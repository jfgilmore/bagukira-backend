require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it 'has valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'validations' do
    it { should allow_value('test@gmail.com').for(:email) }
    it { should_not allow_value('test.gmail.com').for(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should have_secure_password }
  end

  describe 'associations' do
    it { should have_many(:units) }
  end
end
