Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutors, only: :create
    end
  end

  post '/auth/login', to: 'authentication#login'
end
