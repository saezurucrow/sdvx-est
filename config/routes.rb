# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  resources :users, except: :index
end
