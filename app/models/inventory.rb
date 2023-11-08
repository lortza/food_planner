# frozen_string_literal: true

# == Schema Information
#
# Table name: inventories
#
#  id         :bigint           not null, primary key
#  items      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_inventories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Inventory < ApplicationRecord
  belongs_to :user
end
