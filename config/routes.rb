Rails.application.routes.draw do
  # resources :tags
  # resources :ingredients
  resources :recipes, only: %i[show]
  resources :searches, only: %i[index show new create]
  root to: 'searches#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
