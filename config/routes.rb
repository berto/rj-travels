Rails.application.routes.draw do
  root 'home#index'

  get '/about', to: 'home#about'
  get '/map', to: 'home#map'

  # get '/blogs', to: 'blogs#index'
  # get '/blogs/:name', to: 'blogs#show'
  # get '/blogs/new', to: 'blogs#new'
  # get '/blogs/edit', to: 'blogs#edit'
  # post '/blogs', to: 'blogs#create'
  # patch '/blogs/:name', to: 'blogs#upadte'
  # put '/blogs/:name', to: 'blogs#upadte'
  # delete '/blogs/:name', to: 'blogs#upadte'
  # match '/blogs' => "blogs#options", via: :options
  
  resources :blogs
  resources :images
end
