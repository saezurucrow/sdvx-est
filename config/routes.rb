# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'
  get 'howto', to: 'homes#howto'
  get 'support', to: 'homes#support'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get 'users/mypage'
  resources :users

  namespace :users do
    get ':user_id/ex_scores', to: 'ex_scores#index', as: 'ex_scores_index'
    get ':user_id/ex_scores/:id', to: 'ex_scores#show', as: 'ex_score_show'
    post 'ex_scores', to: 'ex_scores#create'
    get 'ex_scores/new', to: 'ex_scores#new'
    resources :upload_statuses, only: [:show]
  end

  get 'user_upload_statuses', to: 'users/upload_statuses#index', as: 'user_upload_statuses_index'

  get 'rankings/songs', to: 'rankings#index'
  get 'rankings/songs/:id', to: 'rankings#show', as: 'ranking'
  get 'rankings/max', to: 'rankings#max'
  # get 'rankings/score_top', to: 'rankings#score_top'

  resource :favorites, only: %i[create destroy]

  post 'favorite_song/:id', to: 'favorite_songs#create', as: 'create_favorite_songs'
  delete 'favorite_song/:id', to: 'favorite_songs#destroy', as: 'destroy_favorite_songs'

  namespace :admins do
    get '/', to: 'users#index'
    resources :users, only: %i[edit update]
    resources :songs, only: %i[index new create edit update destroy]
    get 'statistics', to: 'statistics#index'
    resources :upload_statuses, only: %i[index show destroy]
  end

  get '*path', to: 'application#render_404'
end
