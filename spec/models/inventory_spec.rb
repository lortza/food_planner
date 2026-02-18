# frozen_string_literal: true

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
