require 'rails_helper'

RSpec.describe UnitsController do
  let(:unit) { create(:unit, user: user) }
  let(:invalid_unit) { attributes_for(:unit, :invalid) }
  let(:user) { create(:user) }
  let(:headers) { AuthenticationHelpers.auth_headers(user) }
  let(:json_response) { JSON.parse(response.body) }

  it { should use_before_action(:set_unit) }

  describe 'GET #index' do
    context 'when has no entries' do
      before(:each) do
        request.headers.merge! headers
        get :index
      end

      it { should respond_with(:ok) }

      it 'JSON response contains the correct number of entries' do
        expect(json_response['count']).to eq(0)
      end

      it { expect(JSON.parse(response.body)).to include({ 'units' => [] }) }
    end
  end

  describe 'GET #show' do
    context 'when id does exist' do
      before(:each) do
        get :show, params: { id: unit.unit_hash }
      end

      it { should respond_with(:ok) }
    end

    context 'when id does not exist' do
      before(:each) do
        get :show, params: { id: -1 }
      end

      it { should respond_with(:not_found) }
      it { expect(JSON.parse(response.body)).to eq({}) }
    end
  end

  describe 'POST #create' do
    context 'when unit has invalid attributes' do
      before(:each) do
        request.headers.merge! headers
        post :create, params: { unit: invalid_unit }
      end

      it 'returns the correct number of errors' do
        expect(json_response['errors'].count).to eq(2)
      end

      it 'errors contains the correct message' do
        expect(json_response['errors']).to eq(["Name can't be blank", 'Name is too short (minimum is 3 characters)'])
      end

      it { should respond_with(:unprocessable_entity) }
    end
  end

  describe 'PUT #update' do
    before(:each) do
      request.headers.merge! headers
      put :update, params: { unit: invalid_unit, id: unit.unit_hash }
    end

    it { should respond_with(:internal_server_error) }
  end

  describe 'DELETE #destroy' do
    context 'with invalid id' do
      before(:each) do
        request.headers.merge! headers
        wrong_unit = -1
        delete :destroy, params: { id: wrong_unit }
      end

      it { should respond_with(:not_found) }
    end
  end
end
