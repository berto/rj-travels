Rails.application.routes.draw do
  root 'home#index'

  get '/about', to: 'home#about'
  get '/map', to: 'home#map'
  get '/gallery', to: 'home#gallery'
  get '/gallery/:country', to: 'home#country'

  get '/logout', to: 'auth#logout'
  get '/login', to: 'auth#login'
  post '/login', to: 'auth#create_session'

  get '/feed' => 'blogs#feed'
  resources :blogs
  resources :images
end
