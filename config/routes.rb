# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get 'users/mypage'
  resources :users

  namespace :users do
    get ':user_id/ex_scores', to: 'ex_scores#index', as: 'ex_scores'
    get ':user_id/ex_scores/:id', to: 'ex_scores#show', as: 'ex_score'
    resources :ex_scores, only: %i[new create]
    resources :upload_statuses
  end

  get '*path', to: 'application#render_404'
end
