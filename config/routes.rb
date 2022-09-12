Rails.application.routes.draw do
  devise_for :accounts
  resources :accounts, only: [:show]

  root to: "public#homepage"
end
