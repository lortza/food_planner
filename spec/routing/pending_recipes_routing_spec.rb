# frozen_string_literal: true

require "rails_helper"

RSpec.describe PendingRecipesController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/pending_recipes/new").to route_to("pending_recipes#new")
    end

    it "routes to #create" do
      expect(post: "/pending_recipes").to route_to("pending_recipes#create")
    end
  end
end
