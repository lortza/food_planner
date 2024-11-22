# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExperimentalRecipe, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  describe "a valid recipe" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:source_url) }
  end
end
