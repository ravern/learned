Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :users, skip: [:sessions, :registrations], path_names: { sign_up: 'new' }
  as :user do
    get 'sessions/new', to: 'users/sessions#new', as: :new_user_session
    post 'sessions', to: 'users/sessions#create', as: :user_session
    delete 'sessions', to: 'users/sessions#destroy', as: :destroy_user_session

    resource :user, controller: 'devise/registrations', as: :user_registration
    get 'user/cancel', to: 'devise/registrations#cancel', as: :cancel_user_registration
  end
end
