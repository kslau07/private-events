Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  resources :events
  resources :users, only: %i[show]
  
  #get 'events/:id/add_attendee', to: 'event_attendings#create'
  # resources :attendance, only: %i[create]
end
