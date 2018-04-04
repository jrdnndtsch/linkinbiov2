Rails.application.routes.draw do
  resources :grams
  devise_for :users
  root 'grams#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html 
  get '/import', to: 'grams#import'
  post '/grams/filter_grams', to: 'grams#filter'
  put '/grams/:id/remove', to: 'grams#remove', as: 'remove_gram'

  get '/:id', to: 'blogs#index', as: 'blogs'
  get '/:id/:post_id', to: 'blogs#show', as: 'post'

  get '/actions/users/:id', to: 'actions#get_user_gram_info', as: 'get_user_gram_info'
end
