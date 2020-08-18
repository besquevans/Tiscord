Rails.application.routes.draw do
  root "groups#index"
  resources :groups, only: [:index, :create, :update]
  devise_for :users
end
