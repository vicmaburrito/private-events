Rails.application.routes.draw do
  devise_for :users, :controllers => { users: 'users' }
  root "events#index"
  # resources :events
  # resources :enrollments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
