# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_recipe_tags_on_recipe_id             (recipe_id)
#  index_recipe_tags_on_recipe_id_and_tag_id  (recipe_id,tag_id) UNIQUE
#  index_recipe_tags_on_tag_id                (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#  fk_rails_...  (tag_id => tags.id)
#
FactoryBot.define do
  factory :recipe_tag do
    recipe
    tag
  end
end
