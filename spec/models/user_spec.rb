require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should allow_value('test@gmail.com').for(:email) }
    it { should_not allow_value('test.gmail.com').for(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  context 'associations' do
    it { should have_many(:units) }
  end
end
