Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  get 'signup' => 'users#new', as: 'signup'
  get 'login' => 'sessions#new', as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'
  resources :events
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :enrollments, only: [:create, :destroy, :update]

   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
