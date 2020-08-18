Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'addresses', to: 'users/registrations#edit_address'
    patch 'addresses', to: 'users/registrations#update_address'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :products
  resources :users, only: [:show ]
  get "users/:id" => "users#show"
end
