# frozen_string_literal: true

Rails.application.routes.draw do
  get 'recipes/:id/:slug', to: 'recipes#show', as: 'recipe'
  resources :searches, only: %i[index]
  root to: 'searches#index'
end
