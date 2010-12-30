Snups::Application.routes.draw do
  
  resources :friendships

  devise_for :users, :path_names => { :sign_up => "register"}
  resources :admins
  resources :images
  resources :missions
  resources :comments
  controller(:ratings) do
    match 'ratings/up' => :up
    match 'ratings/down' => :down
  end
  controller(:pages) do
    match 'home' => :home
    match 'profile' => :profile
    match 'tutorial' => :tutorial
    match 'impressum' => :impressum
    match 'favorites' => :favorites
    match 'gallery' => :gallery
  end
  
  match 'mobile/login', :to => "mobile#login", :via => :post

  root :to => "pages#home"
end
