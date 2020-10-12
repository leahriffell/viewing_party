Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new', as: :registration
  post '/users', to: 'users#create'

  post "/login", to: "sessions#create"

  get '/dashboard', to: 'dashboard#index'

  get '/discover', to: 'discover#index'

  get '/movies', to: 'movies#index'
  get '/movies/:id', to: 'movies#show', as: :movie_show

  resources :parties, only: [:new, :create]
end
