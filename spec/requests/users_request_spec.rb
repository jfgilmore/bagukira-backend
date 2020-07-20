require 'rails_helper'

RSpec.describe 'Users', type: :request do
<<<<<<< HEAD
  describe 'GET #index' do
    before(:each) do
      create_list(:user, 2)
      get '/users'
    end

    let(:json_response) { JSON.parse(response.body) }

    it { expect(response).to have_http_status(:success) }

    it 'JSON response contains the correct number of entries' do
      expect(json_response['users'].count).to eq(2)
    end

    it 'JSON response body contains the expected attributes' do
      expect(json_response['users'][0]).to include({
                                                     'id' => User.first.id,
                                                     'email' => User.first.email
                                                   })
    end
  end

  describe 'GET #show' do
    before(:each) do
      create(:user)
      get '/users', params: { id: User.last.id }
    end

    let(:json_response) { JSON.parse(response.body) }

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

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

      before(:each) do
        # Arrange
        # Act
        post '/users', params: { user: user_params }
      end

      it { expect(response).to have_http_status(:created) }

      it 'saves the user to the database' do
        expect(User.last.email).to eq(user_params[:email])
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      # Arrange
      user = create(:user)
      user_params = attributes_for(:user)
      # Act
      put "/users/#{user.id}", params: { user: user_params }
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'PATCH #update' do
    before(:each) do
      # Arrange
      user = create(:user)
      user_params = attributes_for(:user)
      # Act
      put "/users/#{user.id}", params: { user: user_params }
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'DELETE #destroy' do
    let(:user_count) { User.count }

    before(:each) do
      # Arrange
      user = create(:user)
      # Act
      delete "/users/#{user.id}"
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'removes the entry from the database' do
      expect(user_count).to eq(User.count)
    end
  end
=======
  # describe 'GET #index' do
  # end
  # Arrange
  # @first_user = create(:user)
  # @last_user = create(:user)

  # # Act
  # get '/users'
  # @json_response = JSON.parse(response.body)

  # it 'returns http success code' do
  #   expect(response).to have_http_status(:success)
  # end

  # it 'JSON response contains the correct number of entries' do
  #   expect(@json_response['users'].count).to eq(2)
  # end

  # it 'JSON response body contains the expected attributes' do
  #   expect(@json_response['user']).to include({
  #                                               'id' => @first_user.id,
  #                                               'email' => @first_user.email
  #                                             })
  # end
  # end
  # end

  # describe 'POST #create' do
  #   context 'when trail is valid' do
  #     before(:example) do
  #       # Arrange
  #       @trail_params = attributes_for(:trail)
  #       # Act
  #       post '/trails/', params: { trail: @trail_params }
  #     end

  #     it 'returns a http created status' do
  #       expect(response).to have_http_status(:created)
  #     end

  # it 'saves the trail to the database' do
  #   expect(Trail.last.name).to eq(@trail_params[:name])
  # end
  # end

  # context 'when trail is invalid' do
  #   before(:example) do
  #     @trail_params = attributes_for(:trail, :invalid)

  #     post '/trails', { params: @trail_params }
  #     @json_response = JSON.prase(response.body)
  #   end

  #   it 'fails to create' do
  #     expect(response).to have_http_status(:unprocessable_entity)
  #   end

  # it 'returns the correct number of errors' do
  #   expect(@json_response['errors'].count).to eq(1)
  # end

  # it 'errors contain the correct message' do
  #   expect(@json_response['errors'][0]).to eq("Name can't be blank")
  # end
  # end
  # end
>>>>>>> parent of dee36da... Created User request tests for happy paths, all passing. Created UserController tests for sad paths, all passing.  All private methods covered, created rescue from record not found in ApplicationController.
end
