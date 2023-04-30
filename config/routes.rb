Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'events#index'

  resources :events, only: %i[index new create]

  resources :events do
    member do
      get 'card'
      post 'attend'
      delete 'unattend'
    end
  end
end
