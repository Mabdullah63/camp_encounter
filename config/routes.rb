Rails.application.routes.draw do
  #get 'home/index'
  devise_for :users
  devise_scope :user do
      unauthenticated do
        root 'users/registrations#new', as: :unauthenticated_root
      end
      authenticated do
        root 'home#index'
      end
    end
    #root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
