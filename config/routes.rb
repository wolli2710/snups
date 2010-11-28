Snups::Application.routes.draw do
  
  devise_for :users, :path_names => { :sign_up => "register"}
  resources :images
  controller(:pages) do
    match 'home' => :home
    match 'tutorial' => :tutorial
    match 'impressum' => :impressum
    match 'gallery' => :gallery
  end
  
  match 'mobile/login', :to => "mobile#login", :via => :post

  root :to => "pages#home"
end
