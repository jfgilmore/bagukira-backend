require 'rails_helper'

RSpec.describe UnitsController, type: :controller do
  it { should use_before_action(:set_unit) }

  describe 'GET #index' do
    context 'has no entries' do
      before(:each) do
        get :index
      end

      it { should respond_with(:ok) }
      it { expect(response.content_type).to eq('application/json; charset=utf-8') }
      it { expect(JSON.parse(response.body)).to eq({ 'units' => [] }) }
    end
  end

  describe 'GET #show' do
    context 'when id does not exist' do
      before(:each) do
        get :show, params: { id: -1 }
      end

      it { should respond_with(:not_found) }
      it { expect(response.content_type).to eq('application/json; charset=utf-8') }
      it { expect(JSON.parse(response.body)).to eq({}) }
    end

    context 'when id does exist' do
      before(:each) do
        unit = create(:unit)
        get :show, params: { id: unit.id }
      end

      it { should respond_with(:ok) }
      it { expect(response.content_type).to eq('application/json; charset=utf-8') }
    end
  end

  describe 'POST #create' do
    context 'when unit has invalid attributes' do
      before(:each) do
        unit_params = attributes_for(:unit, :invalid)
        post :create, params: { unit: unit_params }
      end

      let(:json_response) { JSON.parse(response.body) }

      it 'returns the correct number of errors' do
        expect(json_response['errors'].count).to eq(2)
      end

      it 'errors contains the correct message' do
        expect(json_response['errors'][0]).to eq("Name can't be blank")
      end

      it { should respond_with(:unprocessable_entity) }
    end
  end

  describe 'PUT #update' do
    before(:each) do
      unit = create(:unit)
      unit_params = attributes_for(:unit, :invalid)
      put :update, params: { unit: unit_params, id: unit.id }
    end

    it { should respond_with(:internal_server_error) }
  end

  describe 'DELETE #destroy' do
    context 'with invalid id' do
      before(:each) do
        wrong_unit = Unit.count + 1
        delete :destroy, params: { id: wrong_unit }
      end

      it { should respond_with(:not_found) }
    end
  end
end
