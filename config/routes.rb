Bookstash::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :books

  get   '/signin', :to => 'sessions#new', :as => :signin
  get   '/signout', :to => 'sessions#destroy', :as => :signout
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  root :to => 'pages#index'
end
