Rails.application.routes.draw do
  get 'users/new'
  get 'users/show'
  get 'users/create'
  get 'users/destroy'
  root 'static_pages#home'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
