Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  resource :user do
    resource :profile
  end
end
