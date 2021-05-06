# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:headers) { AuthenticationHelpers.auth_headers(user) }
  let(:json_response) { JSON.parse(response.body) }

  describe 'GET #index' do
    num_of_users = 3
    let(:users) { create_list(:user, num_of_users) }

    before do
      get '/users', headers: AuthenticationHelpers.auth_headers(users[0])
    end

    it { expect(response).to have_http_status(:ok) }

    it 'JSON response contains the correct number of entries' do
      expect(json_response['users'].count).to eq(num_of_users)
    end

    it { expect(response.content_type).to eq('application/json; charset=utf-8') }

    it 'JSON response body contains the expected attributes' do
      expect(json_response['users'][(num_of_users - 1)]).to include({
                                                                      'id' => users[0].id,
                                                                      'email' => users[0].email
                                                                    })
    end
  end

  describe 'GET #show' do
    before do
      get '/users', params: { id: user }, headers: headers
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it { expect(response.content_type).to eq('application/json; charset=utf-8') }

    it 'returns just one User' do
      expect(json_response['users'].count).to eq(1)
    end

    it 'JSON response contains all desired attributes' do
      expect(json_response['users'][0]).to include({ 'id' => User.last.id, 'email' => User.last.email })
    end
  end

  describe 'POST #create' do
    context 'when user has valid attributes' do
      let(:user_params) { attributes_for(:user) }

      before do
        post '/users', params: { user: user_params }
      end

      it { expect(response).to have_http_status(:created) }

      it { expect(response.content_type).to eq('application/json; charset=utf-8') }

      it 'saves the user to the database' do
        expect(User.last.email).to eq(user_params[:email])
      end
    end
  end

  describe 'PUT #update' do
    before do
      put "/users/#{user.id}", params: { user: user_params }, headers: headers
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'saves the changes to the database' do
      expect(User.find(user[:id]).email).to eq(user_params[:email])
    end
  end

  describe 'PATCH #update' do
    before do
      patch "/users/#{user.id}", params: { user: user_params }, headers: headers
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'DELETE #destroy' do
    let(:user_count) { User.count }

    before do
      delete "/users/#{user.id}", headers: headers
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'removes the entry from the database' do
      expect(user_count).to eq(User.count)
    end
  end
end
