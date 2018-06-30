Rails.application.routes.draw do
  root to: 'pages#index'

  devise_for :users, skip: [:sessions, :passwords], path_names: { sign_up: 'new' }
  as :user do
    get 'sessions/new', to: 'devise/sessions#new', as: :new_user_session
    post 'sessions', to: 'devise/sessions#create', as: :user_session
    delete 'sessions', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
end
