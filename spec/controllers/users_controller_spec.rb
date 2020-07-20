require 'rails_helper'
<<<<<<< HEAD
RSpec.describe UsersController, type: :controller do
  it { should use_before_action(:set_user) }

  describe 'POST #create' do
    context 'when user has invalid attributes' do
      before(:each) do
        user_params = attributes_for(:user, :invalid)
        post :create, params: { user: user_params }
      end

      let(:json_response) { JSON.parse(response.body) }

      it 'returns the correct number of errors' do
        expect(json_response['errors'].count).to eq(1)
      end

      it 'errors contains the correct message' do
        expect(json_response['errors'][0]).to eq('Email is invalid')
=======

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    before(:example) do
      @first_user = create(:user)
      @last_user = create(:user)
      get :index
      @json_response = JSON.parse(response.body)

      it 'JSON response contains the correct number of entries' do
        expect(@json_response['users'].count).to eq(2)
      end

      it 'JSON response body contains the expected attributes' do
        expect(@json_response['users']).to include({
                                                     id: @first_user.id,
                                                     email: @first_user.email
                                                   })
>>>>>>> parent of dee36da... Created User request tests for happy paths, all passing. Created UserController tests for sad paths, all passing.  All private methods covered, created rescue from record not found in ApplicationController.
      end

      it { should respond_with(:success) }
    end
  end

  describe 'GET #show' do
    before do
      user = create(:user)
<<<<<<< HEAD
      user_params = attributes_for(:user, :invalid)
      put :update, params: { user: user_params, id: user.id }
    end
=======
      get :show, params: { id: user.id }
>>>>>>> parent of dee36da... Created User request tests for happy paths, all passing. Created UserController tests for sad paths, all passing.  All private methods covered, created rescue from record not found in ApplicationController.

      it { should respond_with(200) }
    end
  end

  describe 'POST #create' do
    before(:example) do
      # Arrange
      user_params = attributes_for(:user)
      # Act
      post :users, params: { user: user_params }
      it { should permit(:email).for(:create, params: { user: user_params }).on(:user) }
      it { should respond_with(:created) }
    end
  end

  describe 'GET #update' do
    before(:example) do
      # Arrange
      create(:user)
      user_params = attributes_for(:user)
      # Act
      post :users, params: { user: user_params }
      it { should permit(:email).for(:update, params: { user: user_params }).on(:user) }
      it { should respond_with(204) }
    end
  end

  # describe 'DELETE #destroy' do
  #   before { delete :destroy }

  #   it { should respond_with(500..600) }
  # end
  # before(:example) do
  # Arrange
  #

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
end
