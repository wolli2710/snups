Snups::Application.routes.draw do
  
  devise_for :users, :path_names => { :sign_up => "register"}
  resources :mobile
  resources :home

  root :to => "home#index"
end
