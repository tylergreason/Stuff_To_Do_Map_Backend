Rails.application.routes.draw do

  get 'sessions/create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # custom routes 
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  # post '/logout', to: 'sessions#destroy' 

end
