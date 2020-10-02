Rails.application.routes.draw do
  require 'sidekiq/web'
  root 'static_pages#home'
  devise_scope :user do
    get 'signin' => 'users/sessions#new'
    get 'signout' => 'users/sessions#destroy'
    get 'create' => 'users/registrations#new', as: 'new_user'
  end
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  resources :users, only: [:create, :new, :update, :index] do
    resource :profile
  end
  post "/user_exams/save", to: "user_exams#save"
  resources :subjects
  resources :exams
  resources :user_exams
  mount Sidekiq::Web, at: '/sidekiq'
end
