Rails.application.routes.draw do
  namespace :api, format: false do
    get '/ping', to: 'application#ping'
    get '/ping/auth', to: 'application#ping_auth'
    match '*all', to: 'application#cor_preflight', via: :options
    resources :authors, only: %i[index show create]
    resources :playlists, only: %i[index show create update destroy]
    resources :sessions, only: :create
    resources :sounds, only: %i[show create]
    resources :tracks, only: %i[index show create]
    match '*all', to: 'application#not_found', via: :all
  end
end
