Rails.application.routes.draw do

  root                      'static_pages#home'

  get     'signin',   to:   'sessions#new'
  post    'signin',   to:   'sessions#create'
  delete  'signout',   to:  'sessions#destroy'

  get     'signup',   to:   'users#new'
  post    'signup',   to:   'users#create'

  get     'blog',     to:   'static_pages#blog'
  get     'fees',     to:   'static_pages#fees'
  get     'help',     to:   'static_pages#help'

  get     'past',     to:   'events#past'

  resources :events
  resources :users
  resources :invitations

end
