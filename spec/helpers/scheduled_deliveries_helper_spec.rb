# frozen_string_literal: true

RSpec.describe ScheduledDeliveriesHelper, type: :helper do
  describe "display_scheduled_deliveries" do
    it "displays the day of the week, date, and time" do
      delivery_date = "2020-05-12 10:00:00 UTC" # 6am US Eastern
      delivery1 = create(:scheduled_delivery, scheduled_for: delivery_date)
      deliveries = [delivery1]

      expect(helper.display_scheduled_deliveries(deliveries)).to include(delivery1.service_provider)
      expect(helper.display_scheduled_deliveries(deliveries)).to include("Tue 05/12 at 6:00 am")
    end

    it "joins multiple deliveries with a pipe" do
      delivery1 = create(:scheduled_delivery, scheduled_for: 3.days.from_now)
      delivery2 = create(:scheduled_delivery, scheduled_for: 4.days.from_now)
      deliveries = ScheduledDelivery.all

      expect(helper.display_scheduled_deliveries(deliveries)).to include(delivery1.service_provider)
      expect(helper.display_scheduled_deliveries(deliveries)).to include(delivery2.service_provider)
      expect(helper.display_scheduled_deliveries(deliveries)).to include(" | ")
    end

    it "display time in 12-hour format" do
      delivery_date = "2020-05-12 18:00:00 UTC" # 2pm US Eastern
      delivery = create(:scheduled_delivery, scheduled_for: delivery_date)

      expect(helper.display_scheduled_deliveries([delivery])).to include("Tue 05/12 at 2:00 pm")
    end
  end
end
