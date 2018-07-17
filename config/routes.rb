Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, skip: [:sessions, :registrations, :passwords], path_names: { sign_up: 'new' }
  as :user do
    get 'sessions/new', to: 'users/sessions#new', as: :new_user_session
    post 'sessions', to: 'users/sessions#create', as: :user_session
    get 'sessions', to: 'users/sessions#destroy', as: :destroy_user_session

    resource :user, controller: 'users/registrations', as: :user_registration
    get 'user/cancel', to: 'users/registrations#cancel', as: :cancel_user_registration

    resource :password, path: 'user/password', controller: 'users/passwords', as: :user_password, except: [:destroy]
  end

  resources :courses, only: [:new, :create] do
    resources :modus, only: [:new, :create, :index, :show]
  end
end
