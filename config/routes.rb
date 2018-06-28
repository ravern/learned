Rails.application.routes.draw do
  root to: 'pages#index'

  devise_scope :user do
    get 'users/login', to: 'devise/sessions#new'
  end
end
