Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new', as: :registration
  post '/users', to: 'users#create'

  post "/login", to: "sessions#create"

  get '/dashboard', to: 'dashboard#index'

end
