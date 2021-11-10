Rails.application.routes.draw do
  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  root 'pages#home'
  resources :articles
  get 'signup', to: 'users#new'
  # get 'login', to: 'pages#login'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  # post 'users', to: 'users#create'
end
