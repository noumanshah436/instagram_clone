Rails.application.routes.draw do
  devise_for :accounts
  resources :accounts, only: [:show]



  resources :posts, only: [:index, :show, :create, :destroy] do
    resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy], shallow: true
  end

  devise_scope :account do
    root to: "devise/sessions#new"
  end
end
