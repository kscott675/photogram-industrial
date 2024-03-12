Rails.application.routes.draw do
  root "users#feed"
  
  devise_for :users
  
  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  
  get ":username/liked" => "users#liked", as: :liked
<<<<<<< HEAD
  get ":username/feed" => "users#feed", as: :feed
  get ":username/followers" => "users#followers", as: :followers
  get ":username/following" => "users#leaders", as: :following

=======
  get ":username/feed"
  get ":username/followers"
  get ":username/following"
>>>>>>> refs/remotes/origin/rb-tabbed-interface
  get ":username" => "users#show", as: :user

end
