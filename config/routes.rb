Rails.application.routes.draw do
  root "attractions#index"
  resources :session, only: [:create]
  resources :users, only: [:create, :destroy, :update]
  resources :attractions, only: [:index, :create, :destroy, :show, :update]
  resources :reviews, only: [:create, :destroy]
  # custom routes 
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  get '/myAttractions', to: 'attractions#my_attractions'
  get '/myAccount', to: 'users#my_account'
  patch '/updatePassword', to: 'users#update_password'
  patch '/updateEmail', to: 'users#update_email'
  # post '/logout', to: 'sessions#destroy' 

end
