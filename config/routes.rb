Rails.application.routes.draw do

  devise_for :accounts

  resources :accounts, only: [:index,:show]
  resources :stories , only: [ :index , :create, :destroy ]

  post 'account/follow', to: 'accounts#follow'
  delete 'account/unfollow', to: 'accounts#unfollow'

  resources :posts  do
    resources :photos, only: [:create, :destroy],shallow: true
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy, :update], shallow: true
  end

  # to make devise sign in as root path
  devise_scope :account do
    root to: "devise/sessions#new"
  end
end




