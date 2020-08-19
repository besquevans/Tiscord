Rails.application.routes.draw do
  root "groups#index"
  resources :groups, only: [:index, :show, :create, :update] do 
    resources :boards, only: [:create, :update, :destroy]
  end
  
  devise_for :users
end
