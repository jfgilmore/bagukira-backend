Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, :tickets
  resources :units do
    resources :tickets
  end

  match 'projects', to: 'units#index', via: :get
  match 'projects', to: 'units#create', via: :post
  match 'projects/:id', to: 'units#show', via: :get
  match 'projects/:id', to: 'units#update', via: :put
  match 'projects/:id', to: 'units#update', via: :patch
  match 'projects/:id', to: 'units#destroy', via: :delete
end
