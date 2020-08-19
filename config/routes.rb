Rails.application.routes.draw do
  get 'purchases/buy'
  get 'purchases/pay'
  get 'card/new'
  get 'card/show'
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
  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_children_form', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end
  end

  resources :users, only: [:show ]
  resources :categories, only: [:index, :show]

  resources :products do
    resource :purchases do
      member do
        get  "buy"
        post "pay"
        get 'pay', to: 'purchases#pay', as: 'paied'
      end
    end
  end

  resources :card, only: [:new, :create, :index, :destroy] do
  end
  resources :comments, only:[:create,:update,:destroy] do
    member do
      get 'restore'
    end
  end
end
