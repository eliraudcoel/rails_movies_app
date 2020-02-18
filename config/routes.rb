Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # Make admin login the first route of the application
  root 'trestle/auth/sessions#new'

  namespace :api, defaults: { format: :json } do
    resources :sessions, only: %i(create) do
      delete :destroy, on: :collection
    end

    resources :users, only: %i(show create)
    resources :user_movies, only: %i(show update create)
  end
end
