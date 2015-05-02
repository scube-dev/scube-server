Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    get '/ping', to: 'application#ping'
    match '*all', to: 'application#cor_preflight', via: :options
    resources :playlists, only: %i[index show create]
    resources :sessions, only: :create
    resources :sounds, only: :show
    resources :tracks, only: %i[index show]
    match '*all', to: 'application#not_found', via: :all
  end

  resources :playlists

  resources :sessions, only: %i[new create]
  get '/signout', to: 'sessions#destroy'

  resources :sounds, only: :show

  resources :tracks do
    get 'download', on: :member
  end

  resources :users, only: %i[new create]
end
