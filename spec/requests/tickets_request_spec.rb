require 'rails_helper'

RSpec.describe 'Tickets' do
  num_of_tickets = 3
  subject(:ticket) { create(:ticket, unit: unit, ticket_num: 1) }

  let(:unit) { create(:unit) }
  let(:ticket_params) { attributes_for(:ticket) }
  let(:tickets) { create_list(:ticket, num_of_tickets, unit: unit, severity: 'MEDIUM') }
  let(:headers) { AuthenticationHelpers.auth_headers(create(:user)) }
  let(:json_response) { JSON.parse(response.body) }

  describe 'GET #index' do
    context 'with the unit id/hash' do
      before do
        tickets
        get "/units/#{unit.id}/tickets", headers: headers
      end

      it { expect(response).to have_http_status(:success) }

      it { expect(response.content_type).to eq('application/json; charset=utf-8') }

      it 'JSON response contains the correct number of entries' do
        expect(json_response['count']).to eq(num_of_tickets)
      end

      it 'JSON response body contains the expected attributes' do
        expect(json_response['tickets'][0]).to include({ 'subject' => tickets[0]['subject'],
                                                         'status' => tickets[0]['status'],
                                                         'opened_by' => tickets[0]['opened_by'],
                                                         'description' => tickets[0]['description'],
                                                         'ticket_num' => tickets[0]['ticket_num'] })
      end
    end
  end

  describe 'POST #create' do
    context 'when ticket has valid attributes' do
      before do
        post "/units/#{unit.id}/tickets", params: { ticket: ticket_params }
      end

      it { expect(response).to have_http_status(:created) }

      it 'saves the ticket to the database' do
        expect(unit.tickets.last.subject).to eq(ticket_params[:subject])
      end

      it 'adds the ticket number' do
        expect(unit.tickets.last.ticket_num).to eq(1)
      end
    end
  end

  describe 'PUT #update' do
    before do
      ticket
      put "/units/#{unit.unit_hash}/tickets/#{ticket.ticket_num}/", params: { ticket: ticket_params }
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'PATCH #update' do
    before do
      ticket
      patch "/units/#{ticket.unit_id}/tickets/#{ticket.ticket_num}", params: { ticket: ticket_params }
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'DELETE #destroy' do
    before do
      ticket
      delete "/units/#{ticket.unit_id}//tickets/#{ticket.ticket_num}", headers: headers
    end

    it { expect(response).to have_http_status(:no_content) }

    it 'removes the entry from the database' do
      expect(Ticket.count).to eq(0)
    end
  end
end
