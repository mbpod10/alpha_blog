Rails.application.routes.draw do
  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  root 'pages#home'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  # post 'users', to: 'users#create'
end
