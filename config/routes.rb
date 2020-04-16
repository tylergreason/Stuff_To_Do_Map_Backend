Rails.application.routes.draw do
  # root "attractions#index"
  resources :session, only: [:create]
  resources :users, only: [:create, :destroy, :update]
  resources :attractions, only: [:index, :create, :destroy, :show, :update]
  resources :reviews, only: [:create, :destroy]
  resources :otm_attractions, only: [:index]

  # custom routes 
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  get '/myAttractions', to: 'attractions#my_attractions'
  get '/myAccount', to: 'users#my_account'
  patch '/updatePassword', to: 'users#update_password'
  patch '/updateEmail', to: 'users#update_email'
  # post '/logout', to: 'sessions#destroy' 
  
  get '/otmAttractions', to: 'otm_attractions#index'
end
