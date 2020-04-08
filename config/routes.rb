# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'

  # Skip registrations for now so no new users can sign up.
  devise_for :users, skip: [:registrations]

  # When we do want to allow new users to sign up, we need to override the
  # devise registrations controller so that we can run custom UserDataSetup
  # methods using this line:
  # devise_for :users, controllers: { registrations: 'registrations' }

  resources :aisles, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :recipes
  post '/convert_from_experimental', to: 'recipes#convert_from_experimental'
  post '/recipe_copy_for_user', to: 'recipes#copy_for_user'
  resources :experimental_recipes, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :meal_plans do
    member do
      get :copy
    end
  end

  resources :meal_plan_recipes, only: [:create]
  resources :shopping_lists, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :shopping_list_items, only: [:new, :create, :edit, :update, :destroy]
    member do
      get :search
    end
  end

  resources :completed_shopping_list_items, only: [:create, :destroy]
  post 'shopping_lists/:id/deactivate_all', to: 'completed_shopping_list_items#deactivate_all', as: 'deactivate_all_items'

  resources :shopping_list_favorites, only: [:create, :destroy]
  resources :shopping_list_item_builders, only: [:create]

  resources :inventories, only: [:edit, :update] do
    resources :recipe_suggestions, only: [:index]
  end
end
