Rails.application.routes.draw do
  devise_for :users

  # get 'users/index', to: 'users#index'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: "users#index"
  resources :group_entities
  resources :groups
  resources :entities
  resources :users
end
