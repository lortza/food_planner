# frozen_string_literal: true

RSpec.describe ScheduledDelivery, type: :model do
  context "associations" do
    it { should belong_to(:shopping_list) }
  end

  context "validations" do
    it { should validate_presence_of(:service_provider) }
    it { should validate_presence_of(:scheduled_for) }
  end

  describe "scopes" do
    describe "future" do
      let(:current_time) { "2024-05-15 00:00:00.000000000 -0500".to_datetime }

      it "does not include past deliveries" do
        travel_to current_time do
          past_30_min = create(:scheduled_delivery, scheduled_for: 30.minutes.ago)

          results = ScheduledDelivery.future
          expect(results).to_not include(past_30_min)
        end
      end

      it "includes upcoming deliveries" do
        travel_to current_time do
          future_delivery = create(:scheduled_delivery, scheduled_for: 3.hours.from_now)
          results = ScheduledDelivery.future

          expect(results).to include(future_delivery)
        end
      end

      it "displays deliveries in ascending order" do
        travel_to current_time do
          second_delivery = create(:scheduled_delivery, scheduled_for: 3.days.from_now)
          first_delivery = create(:scheduled_delivery, scheduled_for: 2.days.from_now)
          results = ScheduledDelivery.future

          expect(results.first).to eq(first_delivery)
          expect(results.last).to eq(second_delivery)
        end
      end
    end

    describe "today_and_beyond" do
      let(:current_time) { "2024-05-15 00:00:00.000000000 -0500".to_datetime }

      it "does not include yesterday's deliveries" do
        travel_to current_time do
          yesterday = create(:scheduled_delivery, scheduled_for: 1.day.ago)

          results = ScheduledDelivery.today_and_beyond
          expect(results).to_not include(yesterday)
        end
      end

      it "includes deliveries that occurred already today" do
        travel_to current_time do
          past_30_min = create(:scheduled_delivery, scheduled_for: 30.minutes.ago)
          past_60_min = create(:scheduled_delivery, scheduled_for: 1.hour.ago)

          results = ScheduledDelivery.today_and_beyond
          expect(results).to include(past_30_min)
          expect(results).to include(past_60_min)
        end
      end

      it "includes deliveries that have not happened yet today" do
        travel_to current_time do
          in_30_min = create(:scheduled_delivery, scheduled_for: 30.minutes.from_now)
          in_1_hour = create(:scheduled_delivery, scheduled_for: 1.hour.from_now)

          results = ScheduledDelivery.today_and_beyond
          expect(results).to include(in_30_min)
          expect(results).to include(in_1_hour)
        end
      end

      it "includes deliveries happening after today" do
        travel_to current_time do
          tomorrow = create(:scheduled_delivery, scheduled_for: 1.day.from_now)

          results = ScheduledDelivery.today_and_beyond
          expect(results).to include(tomorrow)
        end
      end

      it "displays deliveries in ascending order" do
        second_delivery = create(:scheduled_delivery, scheduled_for: 3.days.from_now)
        first_delivery = create(:scheduled_delivery, scheduled_for: 2.days.from_now)
        results = ScheduledDelivery.today_and_beyond

        expect(results.first).to eq(first_delivery)
        expect(results.last).to eq(second_delivery)
      end
    end
  end
end
