Rails.application.routes.draw do
  devise_for :accounts
  resources :accounts, only: [:index,:show]

  resources :posts  do
    resources :photos, only: [:create, :destroy],shallow: true
    resources :likes, only: [:create, :destroy], shallow: true
    resources :comments, only: [:index, :create, :destroy, :update], shallow: true
  end

  devise_scope :account do
    root to: "devise/sessions#new"
  end
end




