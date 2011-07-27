Scube::Application.routes.draw do
  resources :tracks do
    get 'stream', :on => :member
  end
  resources :playlists

  root :to => 'home#index'
end
