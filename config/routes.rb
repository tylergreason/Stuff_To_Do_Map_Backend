Rails.application.routes.draw do

  # get 'sessions/create'
  resources :session, only: [:create]
  resources :users, only: [:create, :destroy, :update]
  resources :attractions, only: [:index, :create, :destroy, :show, :update]
  # resources :attractions
  # get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # custom routes 
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  get '/myAttractions', to: 'attractions#my_attractions'
  get '/myAccount', to: 'users#my_account'
  get '/updatePassword', to: 'users#update_password'
  # post '/logout', to: 'sessions#destroy' 

end
