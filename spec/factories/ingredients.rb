# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id                :bigint           not null, primary key
#  measurement_unit  :string           default(""), not null
#  name              :string           default(""), not null
#  preparation_style :string           default(""), not null
#  quantity          :float            default(0.0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  recipe_id         :bigint
#
# Indexes
#
#  index_ingredients_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#
FactoryBot.define do
  factory :ingredient do
    recipe { association(:recipe) }
    sequence(:name) { |n| "ingredient name #{n}" }
    quantity { 1.5 }
    measurement_unit { Ingredient::UNITS[1..-1].sample }
  end
end
