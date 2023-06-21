Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutors, only: :create
      resources :courses, only: [:index, :create]
    end
  end

  post '/auth/login', to: 'authentication#login'
end
