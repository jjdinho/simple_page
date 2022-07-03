Rails.application.routes.draw do
  get 'pages/index'
  get 'pages/new'
  post 'pages/create'
  devise_for :users
  get 'public/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "public#index"
end
