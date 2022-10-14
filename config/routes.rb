Rails.application.routes.draw do
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  devise_for :accounts

  resources :profile, only: %i[index show]
  resources :stories, only: %i[index create destroy]
  resources :follows, only: %i[create destroy]

  resources :posts do
    resources :photos, only: %i[create destroy], shallow: true
    resources :likes, only: %i[create destroy], shallow: true
    resources :comments, only: %i[create destroy update], shallow: true
  end

  namespace :api do
    namespace :v1 do
      resources :stories, only: %i[index show]
      resources :profile, only: %i[index]
      resources :followers, only: %i[show]
    end
  end

  devise_scope :account do
    root to: "devise/sessions#new"
  end
end




