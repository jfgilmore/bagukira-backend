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
end
