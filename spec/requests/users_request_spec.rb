require 'rails_helper'

RSpec.describe 'Users', type: :request do
  # describe 'GET #index' do
  # end
  # Arrange
  # @first_user = create(:user)
  # @last_user = create(:user)

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
