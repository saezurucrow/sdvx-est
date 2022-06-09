# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get 'users/mypage'
  resources :users

  post 'ex_scores/:user_id/level_select', to: 'ex_scores#level_select', as: 'ex_scores_level_select'
  get 'ex_scores/:user_id/level_select/:id', to: 'ex_scores#level_show', as: 'ex_scores_level_show'
  resources :ex_scores, only: %i[index new create]

  resources :upload_statuses

  get '*path', to: 'application#render_404'
end
