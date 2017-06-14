Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 get '/' => 'events#index'
 get '/' => 'user#index'
 get 'event/:id' => 'events#show'
 
 get '/users' => 'user#index'
 get '/users/new' => 'user#new'
 post '/users' => 'user#create'
 get '/users/:id' => 'user#show'

 get '/bids' => 'bid#index'
 get '/bids/:id' => 'bid#show'
 get '/bids/new' => 'bid#new'
 post '/bids' => 'bid#create'
 patch '/bids/:id' => 'bid#update'
end
