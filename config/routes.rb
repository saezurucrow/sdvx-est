# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users

  get 'users/mypage'
  resources :users

  get 'ex_scores/level_select'
  get 'ex_scores/level_select/:id', to: 'ex_scores#level_show'
  resources :ex_scores, only: %i[new create]

  resources :upload_statuses

  get '*path', to: 'application#render_404'
end
