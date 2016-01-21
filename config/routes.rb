Rails.application.routes.draw do
  resources :job_applications, except: [:new, :edit]
  resources :work_offers, except: [:new, :edit]
  apipie
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :users, except: [:new, :edit] do
    resources :given_feedbacks,
              only: [:index],
              controller: 'feedbacks/given_feedbacks'
    resources :received_feedbacks,
              only: [:index],
              controller: 'feedbacks/received_feedbacks'
  end
  resources :feedbacks, only: [:show, :create, :update]
end
