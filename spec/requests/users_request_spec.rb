require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) do
      @first_user = create(:user)
      @last_user = create(:user)
      get '/users'
      @json_response = JSON.parse(response.body)
    end

    it { expect(response).to have_http_status(:success) }

    it 'JSON response contains the correct number of entries' do
      expect(@json_response['users'].count).to eq(2)
    end

    it 'JSON response body contains the expected attributes' do
      expect(@json_response['users'][0]).to include({
                                                      'id' => @first_user.id,
                                                      'email' => @first_user.email
                                                    })
    end
  end

  describe 'GET #show' do
    before(:each) do
      @user = create(:user)
      get '/users', params: { id: @user.id }
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'returns just one User' do
      expect(@json_response['users'].count).to eq(1)
    end

    it 'JSON response contains all desired attributes' do
      expect(@json_response['users'][0]).to include({ 'id' => @user.id, 'email' => @user.email })
    end
  end

  describe 'POST #create' do
    context 'when user has valid attributes' do
      before(:each) do
        # Arrange
        @user_params = attributes_for(:user)
        # Act
        post '/users', params: { user: @user_params }
        @json_response = JSON.parse(response.body)
      end

      it { expect(response).to have_http_status(:created) }

      it 'saves the user to the database' do
        expect(User.last.email).to eq(@user_params[:email])
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      # Arrange
      user = create(:user)
      @user_params = attributes_for(:user)
      # Act
      put "/users/#{user.id}", params: { user: @user_params }
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'PATCH #update' do
    before(:each) do
      # Arrange
      user = create(:user)
      @user_params = attributes_for(:user)
      # Act
      put "/users/#{user.id}", params: { user: @user_params }
    end
    it { expect(response).to have_http_status(:success) }
  end

  describe 'DELETE #destroy' do
    before(:each) do
      # Arrange
      @user_count = User.count
      user = create(:user)
      # Act
      delete "/users/#{user.id}"
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'removes the entry from the database' do
      expect(@user_count).to eq(User.count)
    end
  end
end
