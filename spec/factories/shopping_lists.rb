# frozen_string_literal: true

# == Schema Information
#
# Table name: shopping_lists
#
#  id         :bigint           not null, primary key
#  favorite   :boolean          default(FALSE)
#  main       :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_shopping_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :shopping_list do
    user
    sequence(:name) { |n| "Shopping List Name #{n}" }
  end
end
