Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope :api do
    resources :patients, except: [:destroy]
    # resources :clinic_histories, only: [:show, :update]
    resources :users, only: [:index, :create, :show, :update]

    post '/login', to: 'authentication#login'

    get 'admins', to: 'users#get_admins'
    get 'admins/:id', to: 'users#get_admin'
    get 'doctors', to: 'users#get_doctors'
    get 'doctors/:id', to: 'users#get_doctor'
    get 'nurses', to: 'users#get_nurses'
    get 'nurses/:id', to: 'users#get_nurse'
    get 'secretaries', to: 'users#get_secretaries'
    get 'secretaries/:id', to: 'users#get_secretary'

    resources :appointments
    resources :medical_consultations, only: [:index, :create, :show]
    get 'doctors/:id/medical_consultations', to: 'medical_consultations#get_by_doctor'
    get 'patients/:id/medical_consultations', to: 'medical_consultations#get_by_patient'

    get 'today_appointments/:id', to: 'appointments#get_today_appointments'
    get 'patient_controls/:id', to: 'patients#get_patient_controls'
  end
  root to: redirect('/admin')
end
