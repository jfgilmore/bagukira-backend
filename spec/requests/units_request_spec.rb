require 'rails_helper'

<<<<<<< HEAD
RSpec.describe 'Units', type: :request do
  describe 'GET #index' do
    before(:each) do
      create_list(:unit, 2)
      get '/units'
    end

    let(:json_response) { JSON.parse(response.body) }

    it { expect(response).to have_http_status(:success) }

    it 'JSON response contains the correct number of entries' do
      expect(json_response['units'].count).to eq(2)
    end

    it 'JSON response body contains the expected attributes' do
      expect(json_response['units'][0]).to include({
                                                     'id' => Unit.first.id, 'name' => Unit.first.name,
                                                     'user_id' => Unit.first.user_id,
                                                     'unit_type' => Unit.first.unit_type
                                                   })
    end
  end

  describe 'GET #show' do
    before(:each) do
      create(:unit)
      get '/units', params: { id: Unit.last.id }
    end

    let(:json_response) { JSON.parse(response.body) }

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns just one Unit' do
      expect(json_response['units'].count).to eq(1)
    end

    it 'JSON response contains all desired attributes' do
      expect(json_response['units'][0]).to include({ 'id' => Unit.last.id, 'name' => Unit.last.name,
                                                     'user_id' => Unit.last.user_id,
                                                     'unit_type' => Unit.last.unit_type })
    end
  end

  describe 'POST #create' do
    context 'when unit has valid attributes' do
      let(:unit_params) { attributes_for(:unit) }

      before(:each) do
        # Arrange
        # Act
        post '/units', params: { unit: unit_params }
      end

      it { expect(response).to have_http_status(:created) }

      it 'saves the unit to the database' do
        expect(Unit.last.name).to eq(unit_params[:name])
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      # Arrange
      unit = create(:unit)
      unit_params = attributes_for(:unit)
      # Act
      put "/units/#{unit.id}", params: { unit: unit_params }
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'PATCH #update' do
    before(:each) do
      # Arrange
      unit = create(:unit)
      unit_params = attributes_for(:unit)
      # Act
      put "/units/#{unit.id}", params: { unit: unit_params }
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'DELETE #destroy' do
    let(:unit_count) { Unit.count }

    before(:each) do
      # Arrange
      unit = create(:unit)
      # Act
      delete "/units/#{unit.id}"
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'removes the entry from the database' do
      expect(unit_count).to eq(Unit.count)
    end
  end
=======
RSpec.describe "Units", type: :request do

>>>>>>> parent of dee36da... Created User request tests for happy paths, all passing. Created UserController tests for sad paths, all passing.  All private methods covered, created rescue from record not found in ApplicationController.
end
