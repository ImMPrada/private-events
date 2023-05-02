Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'events#index'

  resources :events, only: %i[index show new create destroy]

  resources :attendances, only: %i[create destroy], param: :event_id

  resources :users, only: %i[show]
end
