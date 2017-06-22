Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resource :home, only: :index, controller: :home
  resources :groups do
    resources :tasks
  end
  resources :friends, only: %i[index new create]
  resources :invitations, only: [:index] do
    member do
      put :accept
      put :decline
    end
  end
  resources :tasks_manager, only: :index
end
