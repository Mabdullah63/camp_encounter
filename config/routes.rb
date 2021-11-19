Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :camps, except: :edit
  namespace :admins do
    resources :users
    resources :camps
    resources :locations
  end
  devise_scope :user do
    get 'user', to: "users#show"
    unauthenticated do
      root 'users/registrations#new', as: :unauthenticated_root
    end
    authenticated do
      root 'camps#index'
    end
  end
end
