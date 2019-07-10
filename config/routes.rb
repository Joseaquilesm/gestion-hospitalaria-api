Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope :api do
    resources :patients, except: [:destroy]
    # resources :clinic_histories, only: [:show, :update]
    resources :users, only: [:index, :create, :show, :update]
    get 'admins', to: 'users#get_admins'
    get 'doctors', to: 'users#get_doctors'
    get 'doctors/:id', to: 'users#get_doctor'
    get 'nurses', to: 'users#get_nurses'
    get 'secretaries', to: 'users#get_secretaries'

    resources :appointments
    resources :medical_consultations, only: [:index, :create, :show]
    get 'doctors/:id/medical_consultations', to: 'medical_consultations#get_by_doctor'
    get 'patients/:id/medical_consultations', to: 'medical_consultations#get_by_patient'
  end
  root to: redirect('/admin')
end
