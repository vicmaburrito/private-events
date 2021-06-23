Rails.application.routes.draw do
  root "events#index"

  resources :events
  resources :users
  resources :session, only: [:new, :create, :destroy]
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
