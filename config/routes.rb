Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :tools, only: [:index, :new, :create, :show]

  get 'users/dashboard', to: 'users#dashboard', as: :dashboard
end
