Rails.application.routes.draw do
  root "groups#index"
  resources :groups, only: [:index, :show, :create, :update]
  devise_for :users
end
