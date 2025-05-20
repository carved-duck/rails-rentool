Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :tools, only: [:index, :new, :create, :show] do
    resources :rentals, only: [:create]
  end
end
