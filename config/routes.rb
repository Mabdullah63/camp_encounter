Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :user_applications
  resources :camps do
    post 'start_application', on: :member
  end

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
