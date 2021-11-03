Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
      unauthenticated do
        root 'users/registrations#new', as: :unauthenticated_root
      end
      authenticated do
        root 'home#index'
      end
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
