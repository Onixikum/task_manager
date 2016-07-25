TaskManager::Application.routes.draw do
  resources :users do
    member do
      get :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :relationships, only: [:create, :destroy]

  root 'static_pages#home'

  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/perform', to: 'static_pages#perform', via: 'get'
end
