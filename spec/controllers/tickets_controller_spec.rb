# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketsController do
  let(:unit) { create(:unit) }
  let(:ticket) { create(:ticket, unit: unit, ticket_num: 1) }
  let(:ticket_params) { attributes_for(:ticket, :invalid_subject, unit_hash: ticket.unit_id) }
  let(:invalid_ticket_params) { attributes_for(:ticket, :invalid_opened_by) }
  let(:json_response) { JSON.parse(response.body) }

  # describe 'filter params' do
  #   context 'with create' do
  #     it {
  #       expect(request).to permit(:subject, :status, :opened_by, :unit_id, :description, :closed_by, :ticket_num,
  #                                 :severity).for(:create, params: { unit_id: unit.id, ticket: ticket_params })
  #     }
  #   end
  # end

  describe 'GET #index' do
    context 'when there is no valid unit and no tickets' do
      before do
        get :index, params: { unit_id: unit.id }
      end

      it { expect(json_response).to include({ 'tickets' => [] }) }
    end
  end

  describe 'GET #show' do
    context 'when id does not exist' do
      before do
        get :show, params: { unit_id: unit.id, id: -1 }
      end

      it { should respond_with(:not_found) }
    end
  end

  describe 'POST #create' do
    context 'when ticket has invalid attributes' do
      before do
        post :create, params: { unit_id: unit.id, ticket: invalid_ticket_params }
      end

      it 'returns the correct number of errors' do
        expect(json_response['errors'].count).to eq(1)
      end

      it 'errors contains the correct message' do
        expect(json_response['errors'][0]).to eq("Opened by can't be blank")
      end

      it { should respond_with(:unprocessable_entity) }

      it { should use_before_action(:increment_ticket_num) }
    end
  end

  describe 'PUT #update' do
    before do
      ticket
      put :update, params: { unit_id: ticket.unit_id, id: ticket.ticket_num, ticket: ticket_params }
    end

    it { should respond_with(:internal_server_error) }
  end

  describe 'DELETE #destroy' do
    context 'with invalid id' do
      before do
        wrong_ticket = unit.tickets.count + 1
        delete :destroy, params: { unit_id: unit.id, id: wrong_ticket }
      end

      it { should respond_with(:not_found) }
    end
  end
end
