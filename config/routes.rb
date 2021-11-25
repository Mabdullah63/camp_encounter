Rails.application.routes.draw do
  devise_for :users
  namespace :admins do
    resources :users
  end
  devise_scope :user do
    unauthenticated do
      root 'users/registrations#new', as: :unauthenticated_root
    end
    authenticated do
      root 'home#index'
    end
  end
end
