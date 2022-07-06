Rails.application.routes.draw do
  get 'pages/index'
  get 'pages/new'
  post 'pages/create'
  get 'pages/:id/created', to: 'pages#created', as: 'pages_created'
  get 'pages/:id/edit', to: 'pages#edit', as: 'pages_edit'
  post 'pages/preview', to: 'pages#preview', as: 'pages_preview'
  patch 'pages/:id/update', to: 'pages#update', as: 'pages_update'
  delete 'pages/:id/delete', to: 'pages#destroy', as: 'pages_destroy'
  get 'pages/:id/show_confirmation_modal_for_delete', to: 'pages#show_confirmation_modal_for_delete', as: 'pages_show_confirmation_modal_for_delete'

  devise_for :users
  get 'public/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "public#index"
end
