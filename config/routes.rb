Rails.application.routes.draw do
  root 'home#index'

  get '/about', to: 'home#about'
  get '/map', to: 'home#map'

  get '/logout', to: 'auth#logout'
  get '/login', to: 'auth#login'
  post '/login', to: 'auth#create_session'

  resources :blogs
  resources :images
end
