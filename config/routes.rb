Rails.application.routes.draw do
  resources :grams
  devise_for :users
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
  get '/import', to: 'grams#import'
  post '/grams/filter_grams', to: 'grams#filter'
end
