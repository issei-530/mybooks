Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"
  resources :books do
    resources :reviews, only: [:create]
    member do
      post 'add_to_mylist'
      delete 'remove_from_mylist'
    end
  end
  resources :users do
    member do
      get 'my_list'
    end
  end
end
