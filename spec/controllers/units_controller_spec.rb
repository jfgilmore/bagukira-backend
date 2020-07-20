# require 'rails_helper'

# RSpec.describe UnitsController, type: :controller do
#   describe 'GET #index' do
#     before(:example) do
#       @first_unit = create(:unit)
#       @last_unit = create(:unit)
#       get :index
#       @json_response = JSON.parse(response.body)
#     end

#     it 'JSON response contains the correct number of entries' do
#       expect(@json_response['units'].count).to eq(2)
#     end

#     it 'JSON response body contains the expected attributes' do
#       expect(@json_response['units']).to include({
#                                                    id: @first_unit.id,
#                                                    name: @first_unit.name,
#                                                    user: @first_unit.user
#                                                  })

#       it { should respond_with(:success) }
#     end
#   end

#   describe 'GET #show' do
#     before do
#       @unit = create(:unit)
#       get :show, params: { id: @unit.id }
#     end
#     it { should respond_with(200) }
#   end

#   describe 'POST #create' do
#     before do
#       # Arrange
#       # @unit_params =
#       # Act
#       post :units, format: :json, params: { unit: attributes_for(:unit) }
#     end
#     # it { should require(:unit).permit(:name, :user, :unit_type).for(:create, params: { unit: @unit_params }).on(:unit) }
#     it { should respond_with(:created) }

#     # before do
#     #   unit_params = attributes_for(:unit)
#     #   post :units, params: { unit: unit_params }
#     # end

#     # it { should expect(Unit.last.name).to eq(unit_params[:name]) }
#     # it { should expect(Unit.last.user).to eq(unit_params[:user]) }
#     # it { should expect(Unit.last.unit_type).to eq(unit_params[:unit_type]) }
#   end

#   describe 'GET #update' do
#     before(:example) do
#       # Arrange
#       create(:unit)
#       unit_params = attributes_for(:unit)
#       # Act
#       post :units, params: { unit: unit_params }
#       it { should permit(:name).for(:update, params: { unit: unit_params }).on(:unit) }
#       it { should respond_with(204) }
#     end
#   end

#   # describe 'DELETE #destroy' do
#   #   before { delete :destroy }

#   #   it { should respond_with(500..600) }
#   # end
#   # before(:example) do
#   # Arrange
#   #

#   # # Act
#   # get '/units'
#   # @json_response = JSON.parse(response.body)

#   # it 'returns http success code' do
#   #   expect(response).to have_http_status(:success)
#   # end

#   # it 'JSON response contains the correct number of entries' do
#   #   expect(@json_response['units'].count).to eq(2)
#   # end

#   # it 'JSON response body contains the expected attributes' do
#   #   expect(@json_response['unit']).to include({
#   #                                               'id' => @first_unit.id,
#   #                                               'name' => @first_unit.name
#   #                                             })
#   # end
#   # end
#   # end

#   # context 'when trail is invalid' do
#   #   before(:example) do
#   #     @trail_params = attributes_for(:trail, :invalid)

#   #     post '/trails', { params: @trail_params }
#   #     @json_response = JSON.prase(response.body)
#   #   end

#   #   it 'fails to create' do
#   #     expect(response).to have_http_status(:unprocessable_entity)
#   #   end

#   # it 'returns the correct number of errors' do
#   #   expect(@json_response['errors'].count).to eq(1)
#   # end

#   # it 'errors contain the correct message' do
#   #   expect(@json_response['errors'][0]).to eq("Name can't be blank")
#   # end
#   # end
#   # end
# end
