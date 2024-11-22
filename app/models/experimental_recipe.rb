# frozen_string_literal: true

# == Schema Information
#
# Table name: experimental_recipes
#
#  id         :bigint           not null, primary key
#  image_url  :string
#  source_url :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_experimental_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ExperimentalRecipe < ApplicationRecord
  extend Searchable

  belongs_to :user

  validates :title,
    :source_url,
    presence: true
end
