# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      get '/price',      to: 'stock_prices#price'
      get '/prices',     to: 'stock_prices#prices'
      get '/price_all',  to: 'stock_prices#price_all'

      post '/deposit',   to: 'transactions#create_deposit'
      post '/withdraw',  to: 'transactions#create_withdraw'
      post '/transfer',  to: 'transactions#create_transfer'

      post '/sign_in', to: 'sessions#create'
      delete '/sign_out', to: 'sessions#destroy'

      get '/wallets', to: 'wallets#show'
    end
  end
end
