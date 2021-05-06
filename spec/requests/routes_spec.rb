# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  describe 'User routes' do
    it { should route(:get, '/users').to(controller: :users, action: :index) }
    it { should route(:get, '/users/1').to(controller: :users, action: :show, id: 1) }
    it { should route(:post, '/users').to(controller: :users, action: :create) }
    it { should route(:put, '/users/1').to(controller: :users, action: :update, id: 1) }
    it { should route(:patch, '/users/1').to(controller: :users, action: :update, id: 1) }
    it { should route(:delete, '/users/1').to(controller: :users, action: :destroy, id: 1) }
  end

  describe 'Unit routes' do
    it { should route(:get, '/units').to(controller: :units, action: :index) }
    it { should route(:get, '/units/1').to(controller: :units, action: :show, id: 1) }
    it { should route(:post, '/units').to(controller: :units, action: :create) }
    it { should route(:put, '/units/1').to(controller: :units, action: :update, id: 1) }
    it { should route(:patch, '/units/1').to(controller: :units, action: :update, id: 1) }
    it { should route(:delete, '/units/1').to(controller: :units, action: :destroy, id: 1) }
  end

  describe 'Ticket routes' do
    it { should route(:get, 'units/1/tickets').to(controller: :tickets, action: :index, unit_id: 1) }
    it { should route(:get, 'units/1/tickets/1').to(controller: :tickets, action: :show, unit_id: 1, id: 1) }
    it { should route(:post, 'units/1/tickets').to(controller: :tickets, action: :create, unit_id: 1) }
    it { should route(:put, 'units/1/tickets/1').to(controller: :tickets, action: :update, unit_id: 1, id: 1) }
    it { should route(:patch, 'units/1/tickets/1').to(controller: :tickets, action: :update, unit_id: 1, id: 1) }
    it { should route(:delete, 'units/1/tickets/1').to(controller: :tickets, action: :destroy, unit_id: 1, id: 1) }
  end

  # describe 'Other routes' do
  # post 'login', to: 'user_token#create'
  # get 'status', to: 'status#index'
  # get 'status/user', to: 'status#user'
  # post 'sign-up', to: 'users#create'
  # end
end
