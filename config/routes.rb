Rails.application.routes.draw do
  root 'pages#dashboard'
  devise_for :admins
  devise_for :users
 
  resources :users
  resources :admins
end
