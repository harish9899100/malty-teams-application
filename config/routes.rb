Rails.application.routes.draw do
  resources :teams
  # get 'teams/index'
  # get 'teams/show'
  # get 'teams/new'
  # get 'teams/edit'
  #get 'homes/index'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  get  'invite_user', to: 'homes#new_invite'
post 'invite_user', to: 'homes#create_invite'
  resources :homes, only: [:index, :invite_user]
   root "homes#index"
end
