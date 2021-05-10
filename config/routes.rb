# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :units do
    resources :tickets
  end

  # resource :users, only: :create

  resources :users do
    resources :units, shallow: true
  end

  # Send project invites
  post 'users/:user_id/units/:id/invite', to: 'units#invite'

  # Authentication
  post 'login', to: 'user_token#create' # 'users#create'
  # get 'auto_login', to: 'users#auto_login'
  get 'status', to: 'status#index'
  get 'status/user', to: 'status#user'
  post 'sign-up', to: 'users#create'
end
