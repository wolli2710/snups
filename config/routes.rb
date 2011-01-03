Snups::Application.routes.draw do
  
  resources :friendships
  devise_for :users, :path_names => { :sign_up => "register"}
  resources :images
  resources :missions
  resources :comments
  resources :admins
  
  controller(:ratings) do
    match 'ratings/up' => :up
    match 'ratings/down' => :down
  end
  controller(:reports) do
    match 'reports/image' => :image
    match 'ratings/comment' => :comment
  end
  controller(:pages) do
    match 'home' => :home
    match 'profile' => :profile
    match 'tutorial' => :tutorial
    match 'impressum' => :impressum
    match 'favorites' => :favorites
    match 'gallery' => :gallery
    match 'notice' => :notice
    match 'about' => :about
  end
  
  match 'mobile/login', :to => "mobile#login", :via => :post
  match 'mobile/mission', :to => "mobile#mission", :via => :get

  root :to => "pages#home"
end
