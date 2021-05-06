# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Statuses' do
  let(:user) { create(:user) }
  let(:headers) { AuthenticationHelpers.auth_headers(user) }

  describe '#GET index (verify login)' do
    context 'with user logged in' do
      before do
        user
        get '/status', params: { user: user.id }, headers: headers
      end

      it { expect(response).to have_http_status(:continue) }
    end

    context 'with user unauthorized' do
      before do
        user
        get '/status', params: { user: user.id }
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe '#GET user detail' do
    context 'with user logged in' do
      before do
        user
        get '/status/user', params: { user: user.id }, headers: headers
      end

      it { expect(response).to have_http_status(:ok) }

      it { expect(JSON.parse(response.body)).to include({ 'user' => user.email }) }
    end
  end
end
