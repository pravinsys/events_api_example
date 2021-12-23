Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :users, only: [:index, :create, :show]
        resources :events, only: [:index, :create, :show, :update] do
          get :picture, on: :member
          get :register, on: :member
        end
      end
    end
  end
end
