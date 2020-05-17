# frozen_string_literal: true

RSpec.describe ScheduledDelivery, type: :model do
  context 'associations' do
    it { should belong_to(:shopping_list) }
  end

  context 'validations' do
    it { should validate_presence_of(:service_provider) }
    it { should validate_presence_of(:scheduled_for) }
  end

  describe 'self.future' do
    it 'only displays upcoming deliveries' do
      future_delivery = create(:scheduled_delivery, scheduled_for: 3.days.from_now)
      past_delivery = create(:scheduled_delivery, scheduled_for: 3.days.ago)
      results = ScheduledDelivery.future

      expect(results).to include(future_delivery)
      expect(results).to_not include(past_delivery)
    end

    it 'displays deliveries in ascending order' do
      second_delivery = create(:scheduled_delivery, scheduled_for: 3.days.from_now)
      first_delivery = create(:scheduled_delivery, scheduled_for: 2.days.from_now)
      results = ScheduledDelivery.future

      expect(results.first).to eq(first_delivery)
      expect(results.last).to eq(second_delivery)
    end
  end
end
