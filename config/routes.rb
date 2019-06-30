# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope :api do
    resources :patients, except: [:destroy]
    resources :clinic_histories, only: %i[show update]
    resources :users, only: %i[index create show update]
    resources :appointments
    resources :medical_consultations, only: %i[index create show]
  end
  root to: redirect('/admin')
end
