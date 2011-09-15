Scube::Application.routes.draw do
  resources :sounds, :only => [:show]

  resources :users, :only => [:new, :create]

  resources :sessions, :only => [:new, :create]

  resources :tracks do
    get 'download', :on => :member
  end

  resources :playlists

  root :to => 'home#index'
end
