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
end
