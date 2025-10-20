# frozen_string_literal: true

require "rails_helper"

RSpec.describe TagsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/tags/1").to route_to("tags#show", id: "1")
    end
  end
end
