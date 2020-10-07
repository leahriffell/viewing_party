Rails.application.routes.draw do
  root 'welcome#index'

  get '/registration', to: 'users#new'
  post '/users', to: 'users#create'
end
