Rails.application.routes.draw do
  root 'users#index'
  
  devise_for :admins
  devise_for :users

end
