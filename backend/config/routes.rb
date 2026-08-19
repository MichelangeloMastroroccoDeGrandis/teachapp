Rails.application.routes.draw do
  devise_for :users
  root "courses#index"

  resources :courses do
    resources :lessons, except: [ :index ] do
      member { patch :complete }
    end
    resource :enrollment, only: [ :create, :destroy ]
  end

  namespace :dashboards do
    get "instructor", to: "instructor#show"
    get "student", to: "student#show"
  end
end
