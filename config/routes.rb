Booknecting::Application.routes.draw do
  root 'books#index'
  resources :users, path: 'user', only: :show
  devise_for :users
  resources :books, except: :destroy do
    put :read, on: :member
    resources :tags, only: [:create, :destroy]
  end
  resources :tags, only: :show
end
