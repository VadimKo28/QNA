Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root to: "questions#index"

  resources :questions, shallow: true do
    resources :answers do
      member do
        put "/mark_as_best", to: "answers#mark_best"
      end
    end
  end
end
