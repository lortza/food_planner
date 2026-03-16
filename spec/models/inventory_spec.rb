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
RSpec.describe Inventory, type: :model do
  context "associations" do
    let(:inventory) { build(:inventory) }
    it { should belong_to(:user) }
  end

  context "validations" do
    let(:inventory) { build(:inventory) }
    it { should_not validate_presence_of(:items) }
  end
end
