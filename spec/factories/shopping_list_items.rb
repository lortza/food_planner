# frozen_string_literal: true

# == Schema Information
#
# Table name: shopping_list_items
#
#  id                   :bigint           not null, primary key
#  heb_upc              :string
#  name                 :string
#  quantity             :float
#  recurrence_frequency :string
#  recurrence_quantity  :float            default(0.0)
#  status               :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  aisle_id             :bigint
#  shopping_list_id     :bigint
#
# Indexes
#
#  index_shopping_list_items_on_aisle_id          (aisle_id)
#  index_shopping_list_items_on_shopping_list_id  (shopping_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (aisle_id => aisles.id)
#  fk_rails_...  (shopping_list_id => shopping_lists.id)
#
FactoryBot.define do
  factory :shopping_list_item do
    shopping_list_id { create(:shopping_list).id }
    aisle_id { create(:aisle).id }
    sequence(:name) { |n| "List Item Name #{n}" }
    quantity { 1 }
    heb_upc { '1234' }
    status { 'active' }
  end
end
