require 'rails_helper'

RSpec.describe 'Units' do
  num_of_units = 3
  subject(:unit) { create(:unit, user: user) }

  let(:user) { create(:user) }
  let(:unit_params) { attributes_for(:unit) }
  let(:units) { create_list(:unit, num_of_units, user: user) }
  let(:headers) { AuthenticationHelpers.auth_headers(user) }
  let(:json_response) { JSON.parse(response.body) }

  describe 'GET #index' do
    before(:each) do
      units
      get '/units', headers: headers
    end

    it { expect(response).to have_http_status(:success) }

    it { expect(response.content_type).to eq('application/json; charset=utf-8') }

    it 'JSON response contains the correct number of entries' do
      expect(json_response['count']).to eq(num_of_units)
    end

    it 'JSON response body contains the expected attributes' do
      expect(json_response['units'][0]).to include({
                                                     'name' => units[0]['name'],
                                                     'unit_type' => units[0]['unit_type'],
                                                     'unit_hash' => units[0]['unit_hash']
                                                   })
    end
  end

  describe 'GET #show with generated unit_hash' do
    before(:each) do
      get "/units/#{unit.unit_hash}"
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns just one Unit' do
      expect(json_response['count']).to eq(1)
    end

    it 'JSON response contains all desired attributes' do
      expect(json_response['units']).to include({ 'id' => unit['id'],
                                                  'name' => unit['name'],
                                                  'user_id' => unit['user_id'],
                                                  'unit_type' => unit['unit_type'] })
    end
  end

  describe 'POST #create' do
    context 'when unit has valid attributes' do
      before(:each) do
        post "/users/#{user.id}/units", params: { unit: unit_params }, headers: headers
      end

      it { expect(response).to have_http_status(:created) }

      it 'saves the unit to the database' do
        expect(user.units.last.name).to eq(unit_params[:name])
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      unit
      put "/units/#{unit.unit_hash}", params: { unit: unit_params }, headers: headers
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'PATCH #update' do
    before(:each) do
      unit
      patch "/units/#{unit.unit_hash}", params: { unit: unit_params }
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end

  describe 'DELETE #destroy' do
    before(:each) do
      unit
      delete "/units/#{unit.unit_hash}", headers: headers
      # /users/#{user['user_id']}
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'removes the entry from the database' do
      expect(Unit.count).to eq(0)
    end
  end
end
