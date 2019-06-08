Rails.application.routes.draw do
  namespace :api do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # Pacientes
    resources :patients
  end
end
