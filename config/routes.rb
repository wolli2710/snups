Snups::Application.routes.draw do
  
  get "home/settings"
  
  devise_for :users, :path_names => { :sign_up => "register"}
  
  resources :mobileLogin

  root :to => "home#index"
end
