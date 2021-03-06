Rails.application.routes.draw do
  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  root 'pages#home'
  get 'admin', to: 'pages#admin'
  resources :articles
  resources :categories
  get 'signup', to: 'users#new'
  # get 'articles/search/:search', to: 'articles#search'
  # get 'login', to: 'pages#login'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  # post 'users', to: 'users#create'
  resources :categories, except: [:destroy]
end



