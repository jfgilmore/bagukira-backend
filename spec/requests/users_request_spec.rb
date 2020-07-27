require 'rails_helper'

# RSpec.describe 'Users', type: :request do
# describe 'GET #index' do
#   before(:each) do
#     create_list(:user, 2)
#     get '/users'
#   end

#   let(:json_response) { JSON.parse(response.body) }

#   it { expect(response).to have_http_status(:success) }

#   it 'JSON response contains the correct number of entries' do
#     expect(json_response['users'].count).to eq(2)
#   end

#   # it 'JSON response body contains the expected attributes' do
#   #   expect(json_response['users'][0]).to include({
#   #                                                  'id' => User.first.id,
#   #                                                  'email' => User.first.email
#   #                                                })
#   # end
# end

# describe 'GET #show' do
#   before(:each) do
#     create(:user)
#     get '/users', params: { id: User.last.id }
#   end

#   let(:json_response) { JSON.parse(response.body) }

#   it 'returns http success' do
#     expect(response).to have_http_status(:ok)
#   end

#   it 'returns just one User' do
#     expect(json_response['users'].count).to eq(1)
#   end

#   it 'JSON response contains all desired attributes' do
#     expect(json_response['users'][0]).to include({ 'id' => User.last.id, 'email' => User.last.email })
#   end
# end

# describe 'POST #create' do
#   context 'when user has valid attributes' do
#     let(:user_params) { attributes_for(:user) }

#     before(:each) do
#       post '/users', params: { user: user_params }
#     end

#     it { expect(response).to have_http_status(:created) }

#     it 'saves the user to the database' do
#       expect(User.last.email).to eq(user_params[:email])
#     end
#   end
# end

# describe 'PUT #update' do
#   before(:each) do
#     user = create(:user)
#     user_params = attributes_for(:user)
#     put "/users/#{user.id}", params: { user: user_params }
#   end

#   it { expect(response).to have_http_status(:no_content) }
# end

# describe 'PATCH #update' do
#   before(:each) do
#     user = create(:user)
#     user_params = attributes_for(:user)
#     patch "/users/#{user.id}", params: { user: user_params }
#   end

#   it { expect(response).to have_http_status(:no_content) }
# end

# describe 'DELETE #destroy' do
#   let(:user_count) { User.count }

#   before(:each) do
#     # Arrange
#     user = create(:user)
#     # Act
#     delete "/users/#{user.id}"
#   end

#   it { expect(response).to have_http_status(:no_content) }

#   it 'removes the entry from the database' do
#     expect(user_count).to eq(User.count)
#   end
# end
# end
