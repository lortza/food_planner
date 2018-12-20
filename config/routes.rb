# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'

  resources :recipes
  get 'temp_tiles', to: :temp_tiles, controller: 'recipes'

  resources :meal_plans
end
