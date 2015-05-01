Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    resources :sounds, only: [:show]
    resources :tracks, only: [:index]
    resources :playlists, only: [:index, :create]
    resources :sessions, only: [:create]

    match '*all' => 'application#cor_preflight', via: :options
  end

  resources :sounds, only: [:show]

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create]
  get '/signout' => 'sessions#destroy'

  resources :tracks do
    get 'download', on: :member
  end

  resources :playlists
end
