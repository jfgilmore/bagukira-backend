require 'rails_helper'

RSpec.describe 'Units', type: :request do
  describe 'GET #index' do
    before(:each) do
      @units = create_list(:unit, 2)
      get '/units'
    end

    let(:json_response) { JSON.parse(response.body) }

    # it { expect(response).to have_http_status(:success) }

    # it 'JSON response contains the correct number of entries' do
    #   expect(json_response['units'].count).to eq(2)
    # end

    # it 'JSON response body contains the expected attributes' do
    #   expect(json_response['units'][0]).to include({
    #                                                  'name' => @units.first.name,
    #                                                  'unit_type' => @units.first.unit_type,
    #                                                  'unit_hash' => @units.first.unit_hash
    #                                                })
    # end
  end

  describe 'GET #show' do
    before(:each) do
      unit = create(:unit)
      get '/units', params: { id: unit.unit_hash }
    end

    let(:json_response) { JSON.parse(response.body) }

    # it 'returns http success' do
    #   expect(response).to have_http_status(:ok)
    # end

    # it 'returns just one Unit' do
    #   expect(json_response['units'].count).to eq(1)
    # end

    # it 'JSON response contains all desired attributes' do
    #   expect(json_response['units'][0]).to include({ 'id' => Unit.last.id, 'name' => Unit.last.name,
    #                                                  'user_id' => Unit.last.user_id,
    #                                                  'unit_type' => Unit.last.unit_type })
    # end
  end

  describe 'POST #create' do
    context 'when unit has valid attributes' do
      before(:each) do
        @unit_params = attributes_for(:unit)
        puts @unit_params
        # user = create(:user)
        post '/units', params: { unit: @unit_params }
      end

      # it { expect(response).to have_http_status(:created) }

      # it 'saves the unit to the database' do
      #   expect(Unit.last.name).to eq(@unit_params[:name])
      # end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      unit = create(:unit)
      unit_params = attributes_for(:unit)
      put "/units/#{unit.unit_hash}", params: { unit: unit_params }
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'PATCH #update' do
    before(:each) do
      unit = create(:unit)
      unit_params = attributes_for(:unit)
      patch "/units/#{unit.unit_hash}", params: { unit: unit_params }
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'DELETE #destroy' do
    let(:unit_count) { Unit.count }

    before(:each) do
      unit = create(:unit)
      delete "/units/#{unit.unit_hash}"
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'removes the entry from the database' do
      expect(unit_count).to eq(Unit.count)
    end
  end
end
