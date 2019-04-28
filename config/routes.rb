Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :shifts
      resources :schedules
      resources :users, only: [:index, :create, :edit, :destroy, :update]
      post 'login', to: 'sessions#log_in'
    end
  end
end
