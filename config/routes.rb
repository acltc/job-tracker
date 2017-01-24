Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  devise_for :admins
  devise_for :users

  resources :users do
    resources :leads
  end

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :leads
      end
    end
  end

  resources :admins
end
