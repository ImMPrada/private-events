Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'events#index'

  resources :events, only: %i[index new create]
end
