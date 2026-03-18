# frozen_string_literal: true

# require 'rails_helper'

RSpec.describe "shopping_lists/show", type: :view do
  before(:each) do
    @user = create(:user)
    @shopping_list = create(:shopping_list, user_id: @user.id)
    allow(view).to receive(:current_user).and_return(@user)
    render
  end

  it "displays basic shopping_list info" do
    expect(rendered).to match(/Schedule an upcoming delivery/)
    expect(rendered).to match(/#{@shopping_list.name}/)
  end

  context "when a delivery is present" do
    let(:delivery_time) { 1.day.from_now }
    let(:service_provider) { "foo" }
    let(:scheduled_delivery) { create(:scheduled_delivery, service_provider: service_provider, shopping_list: @shopping_list, scheduled_for: delivery_time) }

    before do
      scheduled_delivery
      create(:shopping_list_item, shopping_list: @shopping_list)
      render
    end

    it "displays the delivery information" do
      delivery_details = "#{scheduled_delivery.service_provider} #{scheduled_delivery.scheduled_for.to_fs(:timestamp)}".squish
      expect(rendered).to match(/Deliveries:/)
      expect(rendered).to match(delivery_details)
    end

    it "displays the add_to_shopping_cart icon" do
      expect(rendered).to match(/add_shopping_cart/)
    end
  end

  context "when a delivery is not present" do
    it "does not display the delivery section" do
      expect(rendered).not_to match(/Deliveries:/)
    end

    it "does not display the add_to_shopping_cart icon" do
      expect(rendered).to_not match(/add_shopping_cart/)
    end
  end
end
