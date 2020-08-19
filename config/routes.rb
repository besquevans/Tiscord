Rails.application.routes.draw do
  root "groups#index"
  resources :groups, only: [:index, :create, :update] do 
    resources :boards, only: [:show, :create, :update, :destroy] do 
      resources :messages, only: [:create]
    end
  end
  
  devise_for :users
end
