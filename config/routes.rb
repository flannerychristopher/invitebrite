Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root                      'events#index'

  get     'signin',   to:   'sessions#new'
  post    'signin',   to:   'sessions#create'
  delete  'logout',   to:   'sessions#destroy'

  get     'signup',   to:   'users#new'
  post    'signup',   to:   'users#create'


  resources :events
  resources :users
  resources :invitations

end
