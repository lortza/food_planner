# frozen_string_literal: true

RSpec.describe ScheduledDelivery, type: :model do
  context 'associations' do
    it { should belong_to(:shopping_list) }
  end

  context 'validations' do
    it { should validate_presence_of(:service_provider) }
    it { should validate_presence_of(:scheduled_for) }
  end

end
