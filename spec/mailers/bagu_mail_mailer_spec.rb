# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaguMailMailer do
  let(:user) { create(:user) }
  let(:unit) { create(:unit) }
  let(:email) { 'test@email.com' }

  describe 'project invite mail' do
    subject(:mail) { described_class.with(user: user, unit: unit, email: email).project_invite_mail }

    before do
      mail
    end

    it { expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Invitation to contribute')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([email])
    end

    it 'renders the url' do
      expect(mail.body.encoded).to include("#{Rails.application.config.allowed_cors_origins}/projects/p/#{unit.id}")
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@bagukira.com'])
    end
  end

  describe 'user_created_mail' do
    subject(:mail) { described_class.with(user: user).user_created_mail }

    before do
      mail
    end

    it { expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Welcome to BaguKira')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@bagukira.com'])
    end
  end

  describe 'user_updated_mail' do
    subject(:mail) { described_class.with(user: user).user_updated_mail }

    before do
      mail
    end

    it { expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Your BaguKira user account has been updated')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@bagukira.com'])
    end
  end

  describe 'user_destroyed_mail' do
    subject(:mail) { described_class.with(user: user).user_destroyed_mail }

    before do
      mail
    end

    it { expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Your BaguKira user account has been deleted')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@bagukira.com'])
    end
  end
end
