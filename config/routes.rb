Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  match 'auth/:provider/callback', to: 'sessions#create', via: :all
  match 'auth/failure', to: 'sessions#create', via: :all
  match 'logout', to: 'sessions#destroy', via: :all
  match 'fetch', to: 'tweets#fetch', via: :all
  resources 'tweets', only: [:index]
end
