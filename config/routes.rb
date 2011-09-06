Scube::Application.routes.draw do
  resources :users, :only => [:new, :create]

  resources :sessions, :only => [:new, :create]

  resources :tracks do
    get 'stream', :on => :member
  end
  resources :playlists

  root :to => 'home#index'
end
