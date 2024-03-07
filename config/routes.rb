Rails.application.routes.draw do
  resources :likes
  resources :follow_requests
  resources :comments
  root "photos#index"
  resources :photos
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
