Rails.application.routes.draw do

  # get 'sessions/create'
  resources :session, only: [:create]
  resources :user, only: [:create, :destroy, :show, :update]
  # get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # custom routes 
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  # post '/logout', to: 'sessions#destroy' 

end
