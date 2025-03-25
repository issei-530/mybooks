Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"

  post '/books/:id/add_to_mylist', to: 'books#add_to_mylist', as: 'add_to_mylist_book'
  get '/users/:id/mylist', to: 'users#my_list', as: 'my_list_user'
  delete 'user_books/:id', to: 'user_books#destroy', as: 'remove_from_mylist'

  resources :books do
    resources :reviews, only: [:create, :destroy]
    member do
      post 'add_to_mylist'
      delete 'remove_from_mylist'
    end
  end

  resources :user_books, only: [:show, :destroy]
end
