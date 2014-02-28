Booknecting::Application.routes.draw do
  devise_for :users
  root 'books#index'
  resources :books, except: :destroy
end
