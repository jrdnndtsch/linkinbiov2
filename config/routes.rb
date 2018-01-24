Rails.application.routes.draw do
  resources :grams
  devise_for :users
  root 'grams#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
  get '/import', to: 'grams#import'
  post '/grams/filter_grams', to: 'grams#filter'

  get '/blogs/:id', to: 'blogs#index', as: 'blogs'
  get 'blogs/:id/post/:post_id', to: 'blogs#show', as: 'post'
end
