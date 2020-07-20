require 'rails_helper'

RSpec.describe UnitsController, type: :controller do
  it { should use_before_action(:set_unit) }

  describe 'POST #create' do
    context 'when unit has invalid attributes' do
      before(:each) do
        unit_params = attributes_for(:unit, :invalid)
        post :create, params: { unit: unit_params }
        @json_response = JSON.parse(response.body)
      end

      it 'returns the correct number of errors' do
        expect(@json_response['errors'].count).to eq(2)
      end

      it 'errors contains the correct message' do
        expect(@json_response['errors'][0]).to eq("Name can't be blank")
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
