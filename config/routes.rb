Rails.application.routes.draw do
  root "groups#index"
  resources :groups, only: [:index, :show, :create, :update]
  resources :boards, only: [:create, :update, :destroy]
  devise_for :users
end
