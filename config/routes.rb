Rails.application.routes.draw do
  devise_for :users, :paths => 'users'

  root "posts#index"

  resources :users do
    resources :posts
    resources :friendships
  end

  resources :friendships
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end