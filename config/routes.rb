Rails.application.routes.draw do
  devise_for :accounts
  resources :accounts, only: [:show]

  root to: "public#homepage"

  resources :posts, only: [:index, :show, :create, :destroy] do
    # resources :photos, only: [:create]
  end

end
