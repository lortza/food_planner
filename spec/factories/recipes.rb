# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id                    :bigint           not null, primary key
#  archived              :boolean          default(FALSE)
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
#  title                 :string           default(""), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :bigint
#
# Indexes
#
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
    nutrition_data_iframe { '' }
    cook_time { rand(0..60) }
    reheat_time { rand(0..60) }
    servings { rand(1..10) }
    instructions do
      [
        'Lorem ipsum dolor sit amet.',
        'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.',
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
        'Nisi ut aliquip ex ea commodo consequat.',
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum.',
        'Excepteur sint occaecat cupidatat non proident.',
        'Sunt in culpa qui officia deserunt mollit anim id est laborum.',
      ].join("\n\n")
    end
    prep_day_instructions do
      [
        'On prep day, lorem ipsum dolor sit amet.',
        'Sint occaecat cupidatat non proident.',
        'Aliquip ex ea commodo consequat.',
      ].join("\n\n")
    end

    reheat_instructions do
      [
        'Reheat by lorem ipsum dolor sit amet.',
        'Nisi ut aliquip ex ea commodo consequat.',
        'Excepteur sint occaecat cupidatat non proident.',
      ].join("\n\n")
    end
  end

  trait :with_2_ingredients do
    after :create do |recipe|
      create_list :ingredient, 2, recipe: recipe
    end
  end
end
