# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'

  resources :recipes
  resources :meal_plans
  resources :shopping_lists

  get 'mockups/recipes'
end
