Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :units do
    resources :tickets
  end

  resources :users do
    resources :units, shallow: true
  end

  # match 'projects', to: 'units#index', via: :get
  # match 'projects', to: 'units#create', via: :post
  # match 'project', to: 'units#create', via: :post
  # match 'project', to: 'units#show', via: :get
  # match 'project', to: 'units#update', via: :put
  # match 'project', to: 'units#update', via: :patch
  # match 'project', to: 'units#destroy', via: :delete
  # match 'projects/:id', to: 'units#show', via: :get
  # match 'projects/:id', to: 'units#update', via: :put
  # match 'projects/:id', to: 'units#update', via: :patch
  # match 'projects/:id', to: 'units#destroy', via: :delete

  # match 'project/tickets', to: 'tickets#index', via: :get
  # match 'project/tickets', to: 'tickets#create', via: :post
  # match 'project/ticket', to: 'tickets#show', via: :get
  # match 'project/ticket', to: 'tickets#update', via: :put
  # match 'project/ticket', to: 'tickets#update', via: :patch
  # match 'projects/:unit_id/tickets/:id', to: 'tickets#show', via: :get
  # match 'projects/:unit_id/tickets', to: 'tickets#create', via: :post
  # match 'projects/:unit_id/tickets/:id', to: 'tickets#update', via: :put
  # match 'projects/:unit_id/tickets/:id', to: 'tickets#update', via: :patch
  # match 'projects/:unit_id/tickets/:id', to: 'tickets#destroy', via: :delete
end
