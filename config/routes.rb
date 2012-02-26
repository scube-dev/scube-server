Scube::Application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :playlists, :only => [:index]
    end

    match '*all' => 'application#cor_preflight', :via => :options
  end

  resources :sounds, :only => [:show]

  resources :users, :only => [:new, :create]

  resources :sessions, :only => [:new, :create]

  resources :tracks do
    get 'download', :on => :member
  end

  resources :playlists

  root :to => 'home#index'
end
