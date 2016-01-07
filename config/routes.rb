Rails.application.routes.draw do
  apipie
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :users, only: [:index, :show, :create, :update, :destroy]
end
