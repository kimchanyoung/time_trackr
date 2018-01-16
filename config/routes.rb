Rails.application.routes.draw do
  devise_for :users
  root to: "user_activities#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :user_activities, only: [:index] do
    collection do
      post :start_activity
      post :end_activity
      post :generate_report
    end
  end
end
