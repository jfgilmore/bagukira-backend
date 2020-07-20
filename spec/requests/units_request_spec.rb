require 'rails_helper'

RSpec.describe 'Units', type: :request do
  describe 'GET #index' do
    before(:each) do
      @first_unit = create(:unit)
      @last_unit = create(:unit)
      get '/units'
      @json_response = JSON.parse(response.body)
    end

    it { expect(response).to have_http_status(:success) }

    it 'JSON response contains the correct number of entries' do
      expect(@json_response['units'].count).to eq(2)
    end

    it 'JSON response body contains the expected attributes' do
      expect(@json_response['units'][0]).to include({
                                                      'id' => @first_unit.id,
                                                      'name' => @first_unit.name,
                                                      'user_id' => @first_unit.user_id,
                                                      'unit_type' => @first_unit.unit_type
                                                    })
    end
  end

  describe 'GET #show' do
    before(:each) do
      @unit = create(:unit)
      get '/units', params: { id: @unit.id }
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns just one Unit' do
      expect(@json_response['units'].count).to eq(1)
    end

    it 'JSON response contains all desired attributes' do
      expect(@json_response['units'][0]).to include({ 'id' => @unit.id, 'name' => @unit.name })
    end
  end

  describe 'POST #create' do
    context 'when unit has valid attributes' do
      before(:each) do
        # Arrange
        @unit_params = attributes_for(:unit)
        # Act
        post '/units', params: { unit: @unit_params }
        @json_response = JSON.parse(response.body)
      end

      it { expect(response).to have_http_status(:created) }

      it 'saves the unit to the database' do
        expect(Unit.last.name).to eq(@unit_params[:name])
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      # Arrange
      unit = create(:unit)
      @unit_params = attributes_for(:unit)
      # Act
      put "/units/#{unit.id}", params: { unit: @unit_params }
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'PATCH #update' do
    before(:each) do
      # Arrange
      unit = create(:unit)
      @unit_params = attributes_for(:unit)
      # Act
      put "/units/#{unit.id}", params: { unit: @unit_params }
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'DELETE #destroy' do
    before(:each) do
      # Arrange
      @unit_count = Unit.count
      unit = create(:unit)
      # Act
      delete "/units/#{unit.id}"
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'removes the entry from the database' do
      expect(@unit_count).to eq(Unit.count)
    end
  end
end
