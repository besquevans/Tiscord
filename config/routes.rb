Rails.application.routes.draw do
  root "boards#show"
  resources :groups, only: [:create, :update] do
    resources :boards, only: [:index, :show, :create, :update, :destroy]
  end

  resources :boards do
    resources :messages, only: [:create]
  end

  devise_for :users
end
