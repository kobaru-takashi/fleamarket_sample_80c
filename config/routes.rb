Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'
  resources :users

  resources :products do
    collection do
      get 'get_category_children'
      #,  defaults: { fomat: 'json'}
      get 'get_category_grandchildren'
      # , defaults: { fomat: 'json'}
      get 'search'
    end
  end
  resources :categories
end
