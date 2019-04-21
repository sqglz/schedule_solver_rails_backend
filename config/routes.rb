Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :shifts
      resources :schedules
      resources :users, only: [:create, :edit, :destroy, :update]
    end
  end
end
