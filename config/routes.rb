Rails.application.routes.draw do

  get '/auth/:provider/setup' => 'sessions#setup'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  root 'top#index'

  get '/top/failure' => 'top#failure'
  resources :photographies
  get '/photography/judge_form' => 'photographies#judge_form', as: :judge_photography_page
  post '/photography/judge/:point' => 'photographies#judge', as: :judge_photography

  get '/photography/ranking' => 'photographies#ranking', as: :photography_ranking

  get '/photography/compare_form' => 'photographies#compare_form', as: :photography_compare_page
  post '/photography/compare' => 'photographies#compare', as: :photography_compare

end
