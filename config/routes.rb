Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    get '/ping', to: 'application#ping'
    get '/ping/auth', to: 'application#ping_auth'
    match '*all', to: 'application#cor_preflight', via: :options
    resources :playlists, only: %i[index show create update destroy]
    resources :sessions, only: :create
    resources :sounds, only: %i[show create]
    resources :tracks, only: %i[index show]
    match '*all', to: 'application#not_found', via: :all
  end

  resources :playlists, only: %i[index new edit create update destroy]

  resources :sessions, only: %i[new create]
  get '/signout', to: 'sessions#destroy'

  resources :sounds, only: :show

  resources :tracks

  resources :keys

  resources :users, only: %i[new create]
end
