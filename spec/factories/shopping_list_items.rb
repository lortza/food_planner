# frozen_string_literal: true

FactoryBot.define do
  factory :shopping_list_item do
    shopping_list_id { create(:shopping_list).id }
    aisle_id { create(:aisle).id }
    sequence(:name) { |n| "List Item Name #{n}" }
    quantity { 1 }
    heb_upc { '1234' }
    status { 'active' }
    purchased { false }
  end
end
