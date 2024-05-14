# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'shopping_lists#show'

  # Clobber sign_up for now so no new users can sign up.
  devise_for :users, path_names: {
    sign_up: ''
  }

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
    resources :scheduled_deliveries, only: [:new, :create, :edit, :update, :destroy]
    resources :shopping_list_items, only: [:new, :create, :edit, :update, :destroy]
    member do
      get :search
    end
  end

  # TODO: refactor these routes to use `member do`
  post 'shopping_list_items/:id/search/activate', to: 'shopping_list_item_statuses#activate_from_search', as: 'activate_from_search'
  post 'shopping_list_items/:id/activate', to: 'shopping_list_item_statuses#activate', as: 'activate_item'
  post 'shopping_list_items/:id/deactivate', to: 'shopping_list_item_statuses#deactivate', as: 'deactivate_item'
  post 'shopping_list_items/:id/add_to_cart', to: 'shopping_list_item_statuses#add_to_cart', as: 'add_to_cart'
  post 'shopping_list_items/:id/remove_from_cart', to: 'shopping_list_item_statuses#remove_from_cart', as: 'remove_from_cart'
  post 'shopping_list_items/:id/deactivate_all', to: 'shopping_list_item_statuses#deactivate_all', as: 'deactivate_all_items'

  resources :shopping_list_favorites, only: [:create, :destroy]
  resources :shopping_list_item_builders, only: [:create]

  resources :inventories, only: [:edit, :update] do
    resources :recipe_suggestions, only: [:index]
  end
end
