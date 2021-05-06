require 'rails_helper'

RSpec.describe UsersController do
  wrong_user = -1
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_params) { attributes_for(:user, :invalid) }
  let(:headers) { AuthenticationHelpers.auth_headers(user) }
  let(:json_response) { JSON.parse(response.body) }

  describe 'GET #index' do
    context 'when has no entries' do
      before do
        request.headers.merge! headers
        get :index
      end

      it { should use_before_action(:authenticate_user) }
    end
  end

  describe 'GET #show' do
    context 'when id does exist' do
      before do
        request.headers.merge! headers
        get :show, params: { id: user }
      end

      it { should use_before_action(:authenticate_user) }

      it { should use_before_action(:set_user) }
    end

    context 'when id does not exist' do
      before do
        request.headers.merge! headers
        get :show, params: { id: wrong_user }
      end

      it { should respond_with(:not_found) }
    end
  end

  describe 'POST #create' do
    context 'when user is missing email' do
      before do
        user_params = attributes_for(:user, :missing_email)
        post :create, params: { user: user_params }
      end

      it 'returns the correct number of errors' do
        expect(json_response['errors'].count).to eq(2)
      end

      it 'errors contains the correct message' do
        expect(json_response['errors']).to eq(["Email can't be blank", 'Email is invalid'])
      end

      it { should respond_with(:unprocessable_entity) }
    end
  end

  describe 'PUT #update' do
    context 'when user has valid attributes' do
      before do
        request.headers.merge! headers
        put :update, params: { id: user, user: user_params }
      end

      it { should use_before_action(:authenticate_user) }

      it { should use_before_action(:set_user) }
    end

    context 'when user has invalid attributes' do
      before do
        request.headers.merge! headers
        put :update, params: { user: invalid_params, id: user }
      end

      it { should respond_with(:internal_server_error) }

      it 'returns the correct number of errors' do
        expect(json_response['errors'].count).to eq(1)
      end

      it "won't save the changes to the database" do
        expect(User.last.email).not_to eq(invalid_params[:email])
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with a valid id' do
      before do
        request.headers.merge! headers
        delete :destroy, params: { id: user }
      end

      it { should use_before_action(:set_user) }

      it { should use_before_action(:authenticate_user) }
    end

    context 'with an invalid id' do
      before do
        request.headers.merge! headers
        delete :destroy, params: { id: wrong_user }
      end

      it { should respond_with(:not_found) }
    end
  end
end
