require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  describe 'private methods' do
    # it { should filter_param(:password) }
    it { should use_before_action(:set_user) }
    it { should rescue_from(ActiveRecord::RecordNotFound).with(:handle_not_found) }
  end

  describe 'GET #index' do
    before(:example) do
      get :index
      @json_response = JSON.parse(response.body)
    end

    it 'JSON response contains the correct number of entries' do
      expect(@json_response['users'].count).to eq(0)
    end
  end

  describe 'POST #create' do
    context 'when user has invalid attributes' do
      before(:each) do
        @user_params = attributes_for(:user, :invalid)
        post :create, params: { user: @user_params }
        @json_response = JSON.parse(response.body)
      end

      it 'returns the correct number of errors' do
        expect(@json_response['errors'].count).to eq(1)
      end

      it 'errors contains the correct message' do
        expect(@json_response['errors'][0]).to eq('Email is invalid')
      end

      it { should respond_with(:unprocessable_entity) }
    end
  end

  describe 'PUT #update' do
    before(:each) do
      user = create(:user)
      @user_params = attributes_for(:user, :invalid)
      put :update, params: { user: @user_params, id: user.id }
    end

    it { should respond_with(:internal_server_error) }
  end

  describe 'DELETE #destroy' do
    context 'with invalid id' do
      before(:each) do
        wrong_user = User.count + 1
        delete :destroy, params: { id: wrong_user }
      end

      it { should respond_with(:not_found) }
    end
  end
end
