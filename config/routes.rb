Rails.application.routes.draw do
  # Devise & JWT configuration :
  # https://medium.com/@nandhae/2019-how-i-set-up-authentication-with-jwt-in-just-a-few-lines-of-code-with-rails-5-api-devise-9db7d3cee2c0
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # Make admin login the first route of the application
  root 'trestle/auth/sessions#new'

  namespace :api, defaults: { format: :json } do
    resources :sessions, only: %i(create) do
      delete :destroy, on: :collection
    end
  end
end
