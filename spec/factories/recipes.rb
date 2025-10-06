# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id                    :bigint           not null, primary key
#  cook_time             :integer          default(0), not null
#  extra_work_note       :string
#  image_url             :string           default(""), not null
#  instructions          :text             default(""), not null
#  last_prepared_on      :date
#  notes                 :text
#  nutrition_data_iframe :text
#  pepperplate_url       :string
#  prep_day_instructions :text             default("")
#  prep_time             :integer          default(0), not null
#  reheat_instructions   :text             default("")
#  reheat_time           :integer          default(0)
#  servings              :integer          default(0), not null
#  source_name           :string           default(""), not null
#  source_url            :string           default(""), not null
#  status                :integer          default("active"), not null
#  title                 :string           default(""), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :bigint
#
# Indexes
#
#  index_recipes_on_status   (status)
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :recipe do
    user
    sequence(:title) { |n| "Recipe Title #{n}" }
    sequence(:source_name) { |n| "Recipe Source #{n}" }
    sequence(:source_url) { |n| "https://example#{n}.com" }
    prep_time { rand(0..20) }
    nutrition_data_iframe { "" }
    cook_time { rand(0..60) }
    reheat_time { rand(0..60) }
    servings { rand(1..10) }
    instructions { Faker::Lorem.sentences(number: 15).join("\n\n") }
    prep_day_instructions { Faker::Hipster.sentences(number: 8).join("\n\n") }
    reheat_instructions { Faker::Lorem.sentences(number: 4).join("\n\n") }

    trait :db_default do
      title { "" }
      source_name { "" }
      source_url { "" }
      servings { 0 }
      instructions { "" }
      prep_time { 0 }
      cook_time { 0 }
      image_url { "" }
      reheat_time { "" }
      status { 1 }
      prep_day_instructions { "" }
      reheat_instructions { "" }
    end

    trait :with_faker_data do
      sequence(:title) { |n| "#{Faker::Food.dish} #{n}" }
      source_name { Faker::Restaurant.name }
      image_url { ["", "https://picsum.photos/400/400", "https://picsum.photos/450/450", "https://loremflickr.com/500/500", "https://loremflickr.com/500/500/food,dessert,drink,dinner,lunch/all", "https://loremflickr.com/400/400/food,dessert,drink,dinner,lunch/all"].sample }
    end

    # This allow you to pass in the number of ingredients you want to build. Ex:
    # create(:recipe, :with_faker_data, :with_faker_ingredients, ingredients_count: 5, user: user)
    transient do
      ingredients_count { 2 }  # default to 2, but can be overridden
    end

    trait :with_2_ingredients do
      after(:create) do |recipe, evaluator|
        create_list(:ingredient, evaluator.ingredients_count, recipe: recipe)
      end
    end

    trait :with_faker_ingredients do
      after(:create) do |recipe, evaluator|
        create_list(:ingredient, evaluator.ingredients_count, :with_faker_data, recipe: recipe)
      end
    end
  end
end
