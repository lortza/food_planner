# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'

  devise_for :users, skip: [:registrations] # this 'skip' prevents people from freating new acconuts

  resources :recipes
  resources :meal_plans
  resources :shopping_lists, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :shopping_list_items, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :list_item_completions, only: [:create, :destroy]
  get 'mockups/recipes'
end
