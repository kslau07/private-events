Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  resources :users, only: %i[show]

  resources :events do
    resources :attendances, only: %i[create]
  end
end
