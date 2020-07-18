require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it { should route(:get, '/users').to(controller: :users, action: :index, format: :json) }
  it { should route(:get, '/users/1').to('users#show', id: 1, format: :json) }
  it { should route(:post, '/users').to('users#create', format: :json) }
  it { should route(:delete, '/users/1').to('users#destroy', id: 1) }
end
