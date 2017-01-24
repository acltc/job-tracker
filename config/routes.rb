Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#dashboard'
  devise_for :admins
  devise_for :users

  resources :users
  resources :admins
  resources :leads
  resources :statuses
end
