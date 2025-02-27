Rails.application.routes.draw do
  devise_for :users
  root to: "book#index"
  resources :books
  resources :users do
    member do
      get 'my_list'
    end
  end
end
