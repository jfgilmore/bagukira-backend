# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { build(:ticket) }

  describe 'validations' do
    it 'has valid factory' do
      expect(build(:ticket)).to be_valid
    end

    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:opened_by) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:unit_id) }
  end

  describe 'relationship' do
    it { should belong_to(:unit) }
  end
end
