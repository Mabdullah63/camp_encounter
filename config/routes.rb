Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :user_applications do
    get 'view_application', on: :member
  end

  resources :camps do
    post 'start_application', on: :member
  end

  namespace :admins do
    resources :users
    resources :camps
    resources :locations
    resources :user_applications, except: [:new, :create]
  end

  namespace :api do
    namespace :v1 do
      resources :user_applications, except: [:edit, :new]
    end
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
