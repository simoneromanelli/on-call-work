Rails.application.routes.draw do
  apipie
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :users, except: [:new, :edit] do
    resources :given_feedbaks,
              only: [:index, :create],
              controller: 'feedbacks/given_feedbacks'
    # resources :received_feedbaks,
    #           only: [:index, :create],
    #           controller: 'ReceivedFeedbacksController'
  end
  resources :feedbacks, only: [:show, :update, :destroy]
end
