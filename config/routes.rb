Rails.application.routes.draw do

  get '/auth/:provider/setup' => 'sessions#setup'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  root 'top#index'

  get '/top/failure' => 'top#failure'

end
