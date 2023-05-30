Rails.application.routes.draw do
  devise_for :users
  root to: 'groups#index'
  get 'groups/index', to: 'groups#index'

  # get 'users/index', to: 'users#index'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users
  resources :groups do
    resources :entities
  end
end
