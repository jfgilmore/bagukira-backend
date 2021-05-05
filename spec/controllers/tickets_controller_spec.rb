require 'rails_helper'

RSpec.describe TicketsController do
  it { should use_before_action(:set_ticket) }
  it { should use_before_action(:set_unit) }

  # describe 'GET #index' do
  #   context 'when there is no valid unit and no tickets' do
  #     before(:each) do
  #       unit = create(:unit)
  #       get :index, params: { ticket: { unit_id: unit.id } }
  #     end

  #     # it { should respond_with(:ok) }
  #     # it { expect(response.content_type).to eq('application/json; charset=utf-8') }
  #     # it { expect(JSON.parse(response.body)).to eq({ 'tickets' => [] }) }
  #   end

  #   context 'when the unit is present but there are no tickets' do
  #     before(:each) do
  #       unit = create(:unit)
  #       get :index, params: { ticket: { unit_id: unit.unit_hash } }
  #     end

  #     # it { should respond_with(:ok) }
  #     # it { expect(response.content_type).to eq('application/json; charset=utf-8') }
  #     # it { expect(JSON.parse(response.body)).to eq({ 'tickets' => [] }) }
  #   end
  # end

  # describe 'GET #show' do
  #   context 'when id does not exist' do
  #     before(:each) do
  #       get :show, params: { id: -1 }
  #     end

  #     # it { should respond_with(:not_found) }
  #     # it { expect(response.content_type).to eq('application/json; charset=utf-8') }
  #     # it { expect(JSON.parse(response.body)).to eq({}) }
  #   end

  #   # context 'when id does exist' do
  #   #   before(:each) do
  #   #     ticket = create(:ticket)
  #   #     get :show, params: { id: ticket.id }
  #   #   end

  #   #   # it { should respond_with(:ok) }
  #   #   # it { expect(response.content_type).to eq('application/json; charset=utf-8') }
  #   end
  # end

  # describe 'POST #create' do
  #   context 'when ticket has invalid attributes' do
  #     before(:each) do
  #       # create(:unit)
  #       ticket_params = attributes_for(:ticket, :invalid_opened_by)
  #       # puts ticket_params
  #       post :create, params: { ticket: ticket_params }
  #     end

  #     let(:json_response) { JSON.parse(response.body) }

  # it 'returns the correct number of errors' do
  #   expect(json_response['errors'].count).to eq(1)
  # end

  # it 'errors contains the correct message' do
  #   expect(json_response['errors'][0]).to eq("Opened by can't be blank")
  # end

  # it { should respond_with(:unprocessable_entity) }
  #   end
  # end

  # describe 'PUT #update' do
  #   before(:each) do
  #     ticket = create(:ticket)
  #     ticket_params = attributes_for(:ticket, :invalid_subject, unit_hash: ticket.unit_id)
  #     put :update, params: { ticket: ticket_params, id: ticket.id }
  #   end

  #   # it { should respond_with(:internal_server_error) }
  # end

  # describe 'DELETE #destroy' do
  #   context 'with invalid id' do
  #     before(:each) do
  #       wrong_ticket = Unit.count + 1
  #       delete :destroy, params: { id: wrong_ticket }
  #     end

  #     # it { should respond_with(:not_found) }
  #   end
  # end
end
