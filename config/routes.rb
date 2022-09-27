Rails.application.routes.draw do
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  
  devise_for :accounts

  # resources :accounts, only: %i[index show]
  resources :profile, only: %i[index show]
  resources :stories, only: %i[index create destroy]

  # post 'account/follow', to: 'accounts#follow'
  # delete 'account/unfollow', to: 'accounts#unfollow'

  post 'account/follow', to: 'profile#follow'
  delete 'account/unfollow', to: 'profile#unfollow'

  resources :posts do
    resources :photos, only: %i[create destroy], shallow: true
    resources :likes, only: %i[create destroy], shallow: true
    resources :comments, only: %i[index create destroy update], shallow: true
  end

  # to make devise sign in as root path
  devise_scope :account do
    root to: "devise/sessions#new"
  end



end




