Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Authentication Paths
  get '/register', to: 'users#new', as: :registration
  post '/register', to: 'users#create'

  # User Profile Paths
  get '/profile', to: 'users#show', as: :profile
  
end
