Rails.application.routes.draw do
  root "boards#show"
  resources :groups, only: [:create, :update] do
    resources :boards, only: [:create]
  end

  resources :boards, only: [:show, :update, :destroy] do
    resources :messages, only: [:create]
  end

  devise_for :users
end
