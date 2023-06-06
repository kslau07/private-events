Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  resources :events, only: %i[new]
  resources :users, only: %i[show]
end
