Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  resources :events, only: %i[index new create show]
  resources :users, only: %i[show]


end
