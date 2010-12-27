Snups::Application.routes.draw do
  
  resources :friendships

  devise_for :users, :path_names => { :sign_up => "register"}
  resources :images
  resources :missions
  resources :comments
  controller(:pages) do
    match 'home' => :home
    match 'profile' => :profile
    match 'tutorial' => :tutorial
    match 'impressum' => :impressum
    match 'gallery' => :gallery
    match 'favorites' => :favorites
  end
  
  match 'mobile/login', :to => "mobile#login", :via => :post

  root :to => "pages#home"
end
