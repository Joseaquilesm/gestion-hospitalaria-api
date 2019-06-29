Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope :api do
    resources :patients, except: [:destroy]
    resources :clinic_histories, only: [:show, :update]
    resources :users, only: [:index, :create, :show, :update]
    resources :appointments
  end
  root :to => redirect('/admin')
end
